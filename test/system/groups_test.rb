require "application_system_test_case"

class GroupsTest < ApplicationSystemTestCase
  test "simulate two user logins" do
    simulate_login_user_one
    find('.user-dropdown').click
    click_on 'Sign Out'
    simulate_login_user_two
    find('.user-dropdown').click
    click_on 'Sign Out'
  end

  test "add a new group" do
    visit simulate_login_path

    visit groups_path

    click_on 'Create A Group'

    fill_in 'group_name', with: 'Group name'
    fill_in 'group_description', with: 'Group description'
    check 'group_is_public'

    click_on 'Create Group'

    assert_selector "#notice", text: "Group was successfully created."
    assert page.has_content?('Group name')
    #Need to add here a test checking the group description, not sure how to find that text on the screen.
    
    #NOW TEST EDIT AND EXISTING GROUP
    click_on 'Edit'
    name = "Group #{rand(10)}"
    fill_in 'group_name', with: name
    fill_in 'group_description', with: 'Changed group description'
    click_on 'Update Group'
    
    #another assert about checking the descripton
    assert page.has_content?(name)
    
    #now test deleting the event
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
    
    assert page.has_content?('error')
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
    # need to fix this... doesn't work.
    select('2', :from => 'group_category_id')
    
    click_on 'Create Group'
    
    
    
    assert_selector "#notice", text: "Group was successfully created."
  end

end
