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

  test "destroy a new group" do
    visit simulate_login_path
    user = User.last

    group = groups(:one)
    group.save
    group.group_memberships.create(user: user)

    visit group_path(group)

    page.accept_confirm do
      click_on 'Delete Group'
    end

    assert_selector "#notice", text: "Group was successfully destroyed."
  end
end
