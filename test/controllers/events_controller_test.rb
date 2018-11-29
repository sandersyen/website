require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "events index works" do
    get simulate_login_path
    get events_path
    assert_response :success
  end
end
