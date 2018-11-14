class User < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :notifications, dependent: :destroy
  has_many :events, through: :groups

  validates :google_id, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  private
    def destroy_notifs
      Notification.where(target: self).or(Notification.where(actor: self)).destroy_all
    end

  # returns all events for this group that start in the future
  def upcoming_events
    events.where('start_time > ?', Time.now)
  end
end
