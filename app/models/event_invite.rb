class EventInvite < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_destroy :destroy_notifs

  def create_notif
    Notification.create(notif_type: 'event_invite', user: self.user, actor: self.event, target: self)
  end

  def destroy_notifs
    Notification.where(target: self).destroy_all
  end
end
