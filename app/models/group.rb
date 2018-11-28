class Group < ApplicationRecord
  belongs_to :category
  has_many :events, dependent: :destroy
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships, dependent: :destroy
  has_many :group_invites, dependent: :destroy
  has_many :posts, class_name: 'GroupPost', dependent: :destroy

  validates :name, length: { in: 3..100 }
  validates :description, length: { maximum: 1000 }
  validates :category, presence: true

  # returns true if the user can modify this group
  def can_edit?(user)
    is_admin?(user)
  end

  def recent_posts
    self.posts.order('created_at DESC')
  end

  # returns all events for this group that start in the future
  def upcoming_events
    events.where('start_time > ?', Time.now)
  end

  def is_member?(user)
    users.include?(user)
  end

  def is_admin?(user)
    user_role(user) == 'ADMIN'
  end

  def admins
    group_memberships.where(role: 'ADMIN')
  end

  def user_to_membership(user)
    group_memberships.find_by(user: user)
  end

  def user_role(user)
    membership = user_to_membership(user)
    membership.nil? ? nil : membership.role
  end

  private
    def destroy_notifs
      Notification.where(target: self).or(Notification.where(actor: self)).destroy_all
    end
end
