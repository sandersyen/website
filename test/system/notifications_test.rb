require "application_system_test_case"

class NotificationsTests < ApplicationSystemTestCase
  test "can view notifications" do
    visit simulate_login_path
    visit notifications_path
  end

  test "can destroy own notification" do
    visit simulate_login_path

    user = User.last

    Notification.create(notif_type: 'test_notif', user: user, actor: user, target: user)

    visit notifications_path

    click_on 'Dismiss'
  end
end 
