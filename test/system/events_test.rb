require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "add a new event" do
    user, group = create_test_group

    visit events_path

    click_on 'Create An Event'

    fill_in 'event_name', with: 'Event name'
    fill_in 'event_description', with: 'Event description'
    select group.name, from: 'event_group_id'

    click_on 'Create Event'

    assert_selector "#notice", text: "Event was successfully created."
  end

  test "edit an existing event" do
    event = create_test_event

    visit event_path(event)

    click_on 'Edit'

    name = "Event #{rand(10)}"
    fill_in 'event_name', with: name

    click_on 'Update Event'

    assert_selector "h3", text: name
  end

  test "destroy a new event" do
    event = create_test_event

    visit event_path(event)

    page.accept_confirm do
      click_on 'Delete Event'
    end

    assert_selector "#notice", text: "Event was successfully destroyed."
  end

  test "add a new event without name" do
    user, group = create_test_group
    
    visit events_path
    
    click_on 'Create An Event'
    
    #fill_in 'event_name', with: 'Event name'
    fill_in 'event_description', with: 'Event description'
    select group.name, from: 'event_group_id'
    
    click_on 'Create Event'
    
    assert_selector "h2", text: "1 error prohibited this event from being saved:"
  end

  test "add a new event with no description" do
    user, group = create_test_group
    
    visit events_path
    
    click_on 'Create An Event'
    
    fill_in 'event_name', with: 'Event name'
    #fill_in 'event_description', with: 'Event description'
    select group.name, from: 'event_group_id'
    
    click_on 'Create Event'
    
    assert_selector "#notice", text: "Event was successfully created."
  end
end
