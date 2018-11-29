class EventsController < ApplicationController
  before_action :set_event, only: [:show, :invite_member, :edit, :update, :destroy]

  # GET /events
  def index
    return if enforce_login(home_path)
    @events = current_user.upcoming_events

    respond_to do |format|
      format.html
      format.json do
        json = @events.map{|event| {
          id: event.id,
          title: event.name,
          description: event.description,
          start: event.start_time,
          end: event.end_time,
          url: event_path(event)
        }}
        render json: json
      end
    end
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    return if enforce_login(events_path)

    @event = Event.new
    @group = Group.find(params[:group_id])
  end

  # GET /events/1/edit
  def edit
    return if enforce_permissions(@event)
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    return if enforce_permissions(@event)

    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def invite_member
    return if enforce_permissions(@event)

    invited_user = User.find_by_email(params[:email])
    invite = EventInvite.new(event: @event, user: invited_user)
    existing_invite = EventInvite.find_by(event: @event, user: invited_user)

    if invited_user.nil?
      redirect_to @event, alert: 'Unable to find that user.'
      return
    end

    if @event.users.include?(invited_user)
      redirect_to @event, alert: 'That user is already in the event.'
      return
    end

    unless existing_invite.nil?
      redirect_to @event, alert: 'That user has already been invite to the group.'
      return
    end

    if invite.save
      invite.create_notif
      redirect_to @event, notice: "You have invited #{invited_user.name} to the event."
      UserMailer.group_invite(invited_user.email).deliver_now
    else
      redirect_to @event, alert: 'Unable to invite that user.'
    end
  end

  # DELETE /events/1
  def destroy
    return if enforce_permissions(@event)

    @event.destroy
    redirect_to events_path, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :start_time, :end_time, :location, :group_id)
    end

    def enforce_permissions(event)
      if !event.can_edit?(current_user)
        redirect_to event, alert: 'You are not allowed to do that.'
        return true
      end
      return false
    end
end
