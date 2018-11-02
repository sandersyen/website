require "application_system_test_case"

class GroupsTest < ApplicationSystemTestCase
  test "add a new group" do
    visit simulate_login_path

    visit groups_path

    click_on 'Create A Group'
  
    fill_in 'group_name', with: 'Group name'
    fill_in 'group_description', with: 'Group description'
    check 'group_is_public'

    click_on 'Create Group'

    assert_selector "#notice", text: "Group was successfully created."
  end
end
