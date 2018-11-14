class Event < ApplicationRecord
  belongs_to :group

  validates :name, presence: true # make sure that the user entered an event name
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :description, length: { maximum: 1000 }

  validate :start_cannot_be_in_the_past, :on => :create
  validate :start_must_be_before_end

  after_destroy_commit :destroy_notifs

  def start_cannot_be_in_the_past
    if start_time.present? && start_time < Time.now - 3600
      errors.add(:start_time, "can't be in the past")
    end
  end

  def start_must_be_before_end
    if start_time.present? && end_time.present? && start_time > end_time
      errors.add(:start_time, "must be before the end time")
    end
  end

  # returns true if the user can edit this event
  def can_edit?(user)
    group.users.include?(user)
  end

  private
    def destroy_notifs
      Notification.where(target: self).or(Notification.where(actor: self)).destroy_all
    end
end
