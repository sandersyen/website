require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "group index works" do
    get groups_path
    assert_response :success
  end
end
