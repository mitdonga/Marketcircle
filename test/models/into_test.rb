require 'test_helper'

class InfoTest < ActiveSupport::TestCase
  setup do
    @user = User.create(name: "John Doe")
  end

  test "should be valid with valid attributes" do
    info = Info.new(email: "john@example.com", user: @user)
    assert info.valid?
  end

  test "should not be valid without an email" do
    info = Info.new(email: nil, user: @user)
    assert_not info.valid?
  end

  test "should not be valid with an invalid email format" do
    info = Info.new(email: "invalid_email", user: @user)
    assert_not info.valid?
  end

  test "should be valid with a valid email format" do
    info = Info.new(email: "john@example.com", user: @user)
    assert info.valid?
  end
end