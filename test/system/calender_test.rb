require "application_system_test_case"

class CalenderTests < ApplicationSystemTestCase
    test "calender" do
        # performs login, creates test group and test event
        event = create_test_event
        # make sure our test event is in the current calendar
        event.update(start_time: Time.now + 1.hour, end_time: Time.now + 2.hours)
        
        visit home_path
        assert page.has_content?('Event1')
    end
end 
