class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true
  belongs_to :actor, polymorphic: true

  validates :actor_id, presence: true
  validates :target_id, presence: true
  validates :notif_type, presence: true

  def self.mark_read(notifs)
    notifs.update_all(is_read: true)
  end
end
