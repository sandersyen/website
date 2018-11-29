require 'simplecov'
SimpleCov.start 'rails'


ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def create_test_event
    visit simulate_login_path
    user = User.last

    group = groups(:one)
    group.save
    group.group_memberships.create(user: user, role: 'ADMIN')

    event = events(:one)
    event.group = group
    event.save

    event
  end

  def create_test_group
    visit simulate_login_path
    user = User.last

    group = groups(:one)
    group.save
    group.group_memberships.create(user: user, role: 'ADMIN')

    [user, group]
  end
  
  def create_test_group_with_user(user)
      group = groups(:one)
      group.save
      group.group_memberships.create(user: user, role: 'ADMIN')
      group
  end

  def simulate_login_user_one
    user = users(:one)
    user.save

    simulate_login_as(user)
    user
  end

  def simulate_login_user_two
    user = users(:two)
    user.save

    simulate_login_as(user)
    user
  end

  def simulate_login_as(user)
    visit simulate_login_path(user_id: user.id)
  end
end
