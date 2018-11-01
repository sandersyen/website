class Group < ApplicationRecord
  belongs_to :category
  has_many :events, dependent: :destroy
  has_many :group_memberships
  has_many :users, through: :group_memberships, dependent: :destroy

  validates :name, length: { in: 3..30 }
  validates :description, length: { maximum: 1000 }
  validates :category, presence: true

  # returns true if the user can modify this group
  def can_edit?(user)
    users.include?(user)
  end
end
