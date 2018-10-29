class Group < ApplicationRecord
  belongs_to :category
  has_many :events
  has_many :group_memberships
  has_many :users, through: :group_memberships

  validates :name, length: { in: 3..30 }
  validates :description, length: { maximum: 1000 }
  validates :category, presence: true 
end
