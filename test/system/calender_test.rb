require "application_system_test_case"

class CalenderTests < ApplicationSystemTestCase
    test "calender" do
        visit simulate_login_path
        event = create_test_event
        visit home_path
        assert page.has_content?('Event1')
    end
end 
