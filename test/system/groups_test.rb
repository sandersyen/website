require "application_system_test_case"

class GroupsTest < ApplicationSystemTestCase
  test "add a new group" do
    visit groups_path

    click_on 'New Group'
  
    fill_in 'Name', with: 'Group name'
    fill_in 'Description', with: 'Group description'
    check 'Is public'

    click_on 'Create Group'

    assert_selector "#notice", text: "Group was successfully created."
  end
end
