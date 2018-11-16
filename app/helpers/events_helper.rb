module EventsHelper
  def group_options(event)
    groups = Group.order(:name).map do |group|
      [group.name, group.id]
    end
    options_for_select(groups, selected: event.group_id)
  end

  def group_default(event, _group)
    groups = Group.where(name: _group.name).map do |group|
      [group.name, group.id]
    end
    options_for_select(groups, selected: event.group_id)
  end
end

