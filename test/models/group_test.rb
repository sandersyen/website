require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup do
    @category = categories(:one)
    @event = events(:one)
    @group = groups(:one)
    @user = users(:one)
  end

  test 'valid group' do
    assert Group.new(name: 'Group name', category: @category).valid?
  end

  test 'group without anything' do
    assert !Group.new.valid?
  end

  test 'group with short name' do
    assert !Group.new(name: 'A', category: @category).valid?
  end

  test 'group with long desc' do
    desc = (1 .. 10000).to_a.map{|i| i.to_s}.join
    assert !Group.new(name: 'Group name', category: @category, description: desc).valid?
  end

  test 'group can add users' do
    assert_difference '@group.users.count' do
      @group.group_memberships.create(user: @user)
    end
  end

  test 'group can have events' do
    assert_difference '@group.events.count' do
      @group.events.create(name: @event.name, start_time: Time.now, end_time: Time.now + 5.seconds)
    end
  end
end
