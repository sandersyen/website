module EventsHelper
  def group_options(event)
    groups = Group.order(:name).map do |group|
      [group.name, group.id]
    end
    options_for_select(groups, selected: event.group_id)
  end
end
