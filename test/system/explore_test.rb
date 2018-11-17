require "application_system_test_case"

class ExplorePage < ApplicationSystemTestCase
    test "view a public group" do
        user, group = create_test_group
        visit explore_path
        #what are the default values with this ^ command. Want to check if this group can
        #be viewed in the event page need to know title of group
    
        click_on 'Group Search'
        
        #assert_selector "h3",text:<name of group created above>
    end

    test "view a public event" do
    event = create_test_event
    visit explore_path
    
    click_on 'Event Search'
    
    assert_selector "h3",text: event.name
    
    end

end
