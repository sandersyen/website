require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "group index works" do
    get simulate_login_path
    get groups_path
    assert_response :success
  end
end
