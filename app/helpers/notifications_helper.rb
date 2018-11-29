module NotificationsHelper
  def render_notification(notification)
    tag = notification.is_read ? :span : :strong
    content_tag(tag) do
      partial_name = notification.notif_type
      if lookup_context.find_all('notifications/_' + partial_name).any?
        render partial: notification.notif_type, locals: { notification: notification }
      else
        notification.to_json.to_s
      end
    end
  end
end
