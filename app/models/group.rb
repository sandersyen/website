class Group < ApplicationRecord
  belongs_to :category
  has_many :events, dependent: :destroy
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships, dependent: :destroy
  has_many :group_invites, dependent: :destroy

  validates :name, length: { in: 3..100 }
  validates :description, length: { maximum: 1000 }
  validates :category, presence: true

  # returns true if the user can modify this group
  def can_edit?(user)
    users.include?(user)
  end

  # returns all events for this group that start in the future
  def upcoming_events
    events.where('start_time > ?', Time.now)
  end

  private
    def destroy_notifs
      Notification.where(target: self).or(Notification.where(actor: self)).destroy_all
    end
end
