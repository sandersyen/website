class GroupMembership < ApplicationRecord
  ROLES = ['USER', 'ADMIN']

  belongs_to :group
  belongs_to :user

  validates :group, presence: true
  validates :user, presence: true
  validates :role, inclusion: {in: ROLES}

  def is_user?
    self.role == 'USER'
  end

  def is_admin?
    self.role == 'ADMIN'
  end
end
