class User < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  validates :google_id, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
