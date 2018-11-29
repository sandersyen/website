require 'simplecov'
SimpleCov.start 'rails'


ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def simulate_login_user_one
    simulate_login_as(users(:one))
  end

  def simulate_login_user_two
    simulate_login_as(users(:two))
  end

  def simulate_login_as(user)
    visit simulate_login_path(user_id: user.id)
    user
  end
end
