require "application_system_test_case"

class InviteUsersTest < ApplicationSystemTestCase
    test "simulate inviting to group" do
        user2 = users(:two)
        user = simulate_login_user_one
        group = create_test_group_with_user(user)
        visit group_path(group)
        click_on 'Invite Members'
        fill_in 'invite_member_email', with: user2.email
        click_on 'Invite'
        
        assert_selector"#notice", text: "You have invited " + user2.name + " to the group."
        
        find('.img-circular').hover
        click_on 'Sign Out'
        
        user = simulate_login_user_two
        visit @group
        click_on 'Accept Invite'
        
        assert_selector"#notice", text: "Joined group successfully."
    
    end
end
