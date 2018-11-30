class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :copy]

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
      j
      if !event.can_edit?(current_user)
        redirect_to event, alert: 'You are not allowed to do that.'
        return true
      end
      return false
    end
end
