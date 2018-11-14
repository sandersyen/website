module NotificationsHelper
  def render_notification(notification)
    tag = notification.is_read ? :span : :strong
    content_tag(tag) do
      render partial: notification.notif_type, locals: { notification: notification }
    end
  end
end
