class GroupInvite < ApplicationRecord
  belongs_to :user
  belongs_to :group

  after_destroy :destroy_notifs

  def create_notif
    Notification.create(notif_type: 'group_invite', user: self.user, actor: self.group, target: self)
  end

  def destroy_notifs
    Notification.where(target: self).destroy_all
  end
end
