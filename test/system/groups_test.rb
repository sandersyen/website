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

  test "edit an existing group" do
    user, group = create_test_group

    visit group_path(group)

    click_on 'Edit'

    name = "Group #{rand(10)}"
    fill_in 'group_name', with: name

    click_on 'Update Group'

    assert_selector "h3", text: name
  end

  test "destroy a new group" do
    user, group = create_test_group

    visit group_path(group)

    page.accept_confirm do
      click_on 'Delete Group'
    end

    assert_selector "#notice", text: "Group was successfully destroyed."
  end

  test "test no group name of event" do
    visit simulate_login_path
    
    visit groups_path
    
    click_on 'Create A Group'
    
    #fill_in 'group_name', with: 'Group name'
    fill_in 'group_description', with: 'Group description'
    check 'group_is_public'
    
    click_on 'Create Group'
    
    assert_selector "h2", text: "1 error prohibited this group from being saved:"
  end

  test "test no group description of event" do
    visit simulate_login_path
    
    visit groups_path
    
    click_on 'Create A Group'
    
    fill_in 'group_name', with: 'Group name'
    #fill_in 'group_description', with: 'Group description'
    check 'group_is_public'
    
    click_on 'Create Group'
    
    assert_selector "#notice", text: "Group was successfully created."
  end

  test "add a new group test bussness category" do
    visit simulate_login_path
    
    visit groups_path
    
    click_on 'Create A Group'
    
    fill_in 'group_name', with: 'Group name'
    fill_in 'group_description', with: 'Group description'
    check 'group_is_public'
    
    select('2', :from => 'group_category_id')
    
    click_on 'Create Group'
    
    
    
    assert_selector "#notice", text: "Group was successfully created."
  end

end
