require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user without google id" do
    assert User.new(email: 'test@gmail.com').invalid?
  end

  test "user with bad email" do
    assert User.new(google_id: 'testing', email: 'not-an-email!!').invalid?
    assert User.new(google_id: 'testing', email: 'bademail@').invalid?
  end
end
