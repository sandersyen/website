class EventsController < ApplicationController
  before_action :set_event, only: [:show, :invite_member, :edit, :copy, :update, :destroy, :accept_invite, :ratings]


  # GET /events
  def index
    return if enforce_login(home_path)
    @upcoming_events = current_user.upcoming_events
    @past_events = current_user.past_events

    respond_to do |format|
      format.html
      format.json do
        json = current_user.events.map{|event| {
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

  # GET /events/:id/copy
  def copy
    return if enforce_login(events_path)

    @event = @event.dup
    @group = @event.group
    render :new
  end

  # GET /events/:id/rating
  def ratings
    return if enforce_login(events_path)
    # @event

    rating = Integer(params[:rating])
    Rating.where(user: current_user, event: @event).destroy_all
    Rating.create(user: current_user, event: @event, rating: rating)
    redirect_to events_path, notice: 'You\'ve successfully rated the event.'
  end

  # GET /events/new
  def new
    return if enforce_login(events_path)

    @group = Group.find(params[:group_id])
    @event = Event.new(group: @group)

    # default new event times
    @event.start_time = (Time.now + 1.hour + 1.day).beginning_of_hour
    @event.end_time = @event.start_time + 2.hours

    if @group.nil?
      redirect_to home_path, alert: 'Unable to find that group.'
    end
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

  def accept_invite
    invite = EventInvite.find_by(event: @event, user: current_user)

    @attendee = @event.event_attendees.new(user: current_user)

    if invite.nil?
      redirect_to events_path, notice: 'You have not been invited to that event.'
    elsif @attendee.save
      invite.destroy
      redirect_to @event, notice: 'Joined event successfully.'
    else
      redirect_to @event, notice: 'Unable to join that event, try again.'
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
      UserMailer.event_invite(invited_user.email).deliver_now
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
    # group events into days
    def partition_events(events)
      dates = events.map{|event| event.start_time.to_date}.uniq.sort
      partitions = []
      dates.each do |date|
        partitions.push(events.select{|event| event.start_time.to_date == date})
      end
      partitions
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      times = params[:event][:times].split(' - ')

      start_time = Time.strptime(times[0], '%m/%d/%Y %I:%M %P')
      end_time = Time.strptime(times[1], '%m/%d/%Y %I:%M %P')

      params[:event][:start_time] = start_time
      params[:event][:end_time] = end_time

      params.require(:event).permit(:name, :description, :start_time, :end_time, :location, :group_id, :is_viewable )
    end

    def enforce_permissions(event)
      if !event.can_edit?(current_user)
        redirect_to event, alert: 'You are not allowed to do that.'
        return true
      end
      return false
    end
end
