class User < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :notifications, dependent: :destroy

  validates :google_id, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  private
    def destroy_notifs
      Notification.where(target: self).or(Notification.where(actor: self)).destroy_all
    end
end
