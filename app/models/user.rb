class User < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
end
