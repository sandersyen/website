require "application_system_test_case"

class InviteUsersTest < ApplicationSystemTestCase
    test "simulate inviting to group" do
        user1 = simulate_login_user_one
        user2 = create_random_user
        group = groups(:one)
        

        visit group_path(group)
        click_on 'Invite Members'
        fill_in 'invite_member_email', with: user2.email
        fill_in 'invite_member_email', with: user2.email # fix for capybara bug, sometimes it doesnt fill all the way
        click_on 'Invite'
        
        assert_selector"#notice", text: "You have invited " + user2.name + " to the group."
        
        find('.nav-link.dropdown-toggle').click
        click_on 'Sign Out'
        
        simulate_login_as(user2)
        visit group_path(group)
        click_on 'Accept Invite'
        
        assert_selector"#notice", text: "Joined group successfully."
    end

    test "invite with notification" do
        user1 = simulate_login_user_one
        user2 = users(:two)
        group = groups(:one)
    
        visit group_path(group)
        click_on 'Invite Members'
        fill_in 'invite_member_email', with: user2.email
        fill_in 'invite_member_email', with: user2.email
        click_on 'Invite'
    
        assert_selector"#notice", text: "You have invited " + user2.name + " to the group."
    
        find('.nav-link.dropdown-toggle').click
        click_on 'Sign Out'
        
        simulate_login_as(user2)
    
        find('.nav-link.dropdown-toggle').click
        click_on 'Notifications (1)'
        click_on 'You have been invited to the group'
        click_on 'Accept Invite'
        assert_selector"#notice", text: "Joined group successfully."
    end

    test "invite user that doesn't exist" do
        user1 = simulate_login_user_one
        user2 = users(:two)
        group = groups(:one)

        visit group_path(group)
        click_on 'Invite Members'
        fill_in 'invite_member_email', with: 'NotARealEmail'
        click_on 'Invite'

        assert_selector"#alert", text: "Unable to find that user."
    end

    test "invite a user twice to the group" do
        user1 = simulate_login_user_one
        user2 = users(:two)
        group = groups(:one)

        visit group_path(group)
        click_on 'Invite Members'
        fill_in 'invite_member_email', with: user2.email
        fill_in 'invite_member_email', with: user2.email
        click_on 'Invite'

        visit group_path(group)
        click_on 'Invite Members'
        fill_in 'invite_member_email', with: user2.email
        fill_in 'invite_member_email', with: user2.email
        click_on 'Invite'

        assert_selector"#alert", text: "That user has already been invite to the group."
    end
end
