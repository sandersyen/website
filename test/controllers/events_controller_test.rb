require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "events index works" do
    get events_path
    assert_response :success
  end
end
