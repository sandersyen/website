class Event < ApplicationRecord
  belongs_to :group

  validates :name, presence: true # make sure that the user entered an event name

  validate :start_cannot_be_in_the_past

  def start_cannot_be_in_the_past
    if start_time < Time.now - 3600
      errors.add(:start_time, "can't be in the past")
    end
  end

  # returns true if the user can edit this event
  def can_edit?(user)
    group.users.include?(user)
  end
end
