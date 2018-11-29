require "application_system_test_case"

class ExplorePage < ApplicationSystemTestCase
    test "view a public group" do
        user, group = users(:one), groups(:one)
        simulate_login_as(user)
        visit explore_path
    
        click_on 'Group Search'
        
        assert_selector "h3",text:'Group1'
    end

    test "view a public event" do
        event = events(:one)
        visit explore_path
        
        click_on 'Event Search'
        
        assert_selector "h3", text: event.name
    end
end
