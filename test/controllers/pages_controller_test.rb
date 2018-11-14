require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "all misc pages work" do
    get home_path
    assert_response :success

    get about_path
    assert_response :success

    get terms_path
    assert_response :success

    get explore_path
    assert_response :success
  end
end
