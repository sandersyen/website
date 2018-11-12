require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @event = events(:one)
    @group = groups(:one)
  end

  test 'valid event' do
    assert Event.new(name: 'Event name', group: @group, start_time: Time.now, end_time: Time.now).valid?
  end

  test 'event without anything' do
    assert Event.new.invalid?
  end

  test 'group with long desc' do
    desc = (1 .. 10000).to_a.map{|i| i.to_s}.join
    assert Event.new(name: 'Event name', group: @group, description: desc, start_time: Time.now, end_time: Time.now).invalid?
  end

  test 'group with bad end time' do
    assert Event.new(name: 'Event name', group: @group, start_time: Time.now, end_time: Time.now - 10.seconds).invalid?
  end
end
