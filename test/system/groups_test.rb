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
    click_on 'edit_group'
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
    
    select('2', :from => 'group_category_id')
    
    click_on 'Create Group'
    
    assert_selector "#notice", text: "Group was successfully created."
  end

    test "test group posts and delete" do
        user1 = simulate_login_user_one
        group = groups(:one)
        visit group_path(group)
        fill_in 'group_post_body', with: 'test message'
        click_on 'Post'
        assert page.has_content?('test message')
        find("#post_id-" + GroupPost.last.id.to_s).click
        assert_selector "#notice", text: "Post was deleted successfully."
        assert !page.has_content?('test message')
    end

    test "empty post" do
        user1 = simulate_login_user_one
        group = groups(:one)
        visit group_path(group)
        click_on 'Post'
        assert page.has_content?('Body can\'t be blank')
    end
end
