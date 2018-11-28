class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :body, presence: true

  def can_delete?(user)
    self.user == user || self.group.is_admin?(user)
  end
end
