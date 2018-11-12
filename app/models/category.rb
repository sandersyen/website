class Category < ApplicationRecord
  has_many :groups

  validates :name, length: { in: 3..100 }
end
