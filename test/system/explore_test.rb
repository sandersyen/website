require "application_system_test_case"

class ExplorePage < ApplicationSystemTestCase
    test "view a public group" do
        user, group = create_test_group
        visit explore_path
    
        click_on 'Group Search'
        
        assert_selector "h3",text:'Group1'
    end

    test "view a public event" do
    event = create_test_event
    visit explore_path
    
    click_on 'Event Search'
    
    assert_selector "h3",text: event.name
    
    end

end
