require "application_system_test_case"

class CalenderTests < ApplicationSystemTestCase
    test "calender" do
        event = events(:one)
        simulate_login_as(event.group.users.first)

        # make sure our test event is in the current calendar
        event.update(start_time: Time.now + 1.hour, end_time: Time.now + 2.hours)
        
        visit home_path
        assert page.has_content?(event.name)
    end
end 
