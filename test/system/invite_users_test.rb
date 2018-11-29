require "application_system_test_case"

class InviteUsersTest < ApplicationSystemTestCase
    test "simulate inviting to group" do
        user1 = simulate_login_user_one
        user2 = users(:two)
        group = groups(:one)
        
        visit group_path(group)
        click_on 'Invite Members'
        fill_in 'invite_member_email', with: user2.email
        click_on 'Invite'
        
        assert_selector"#notice", text: "You have invited " + user2.name + " to the group."
        
        find('.img-circular').hover
        click_on 'Sign Out'
        
        simulate_login_as(user2)
        visit group_path(group)
        click_on 'Accept Invite'
        
        assert_selector"#notice", text: "Joined group successfully."
    end
end
