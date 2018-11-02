class Event < ApplicationRecord
  belongs_to :group

  # returns true if the user can edit this event
  def can_edit?(user)
    group.users.include?(user)
  end
end
