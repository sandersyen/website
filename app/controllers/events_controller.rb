class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    return if enforce_login(home_path)
    @events = current_user.upcoming_events
    @past_events = current_user.past_events
    
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
