require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "is valid with valid attributes" do
    user = User.new(name: "John Doe")
    assert user.valid?
  end

  test "is not valid without a name" do
    user = User.new(name: nil)
    assert_not user.valid?
  end

  test "destroys associated info when user is destroyed" do
    user = User.create(name: "John Doe")
    info = user.create_info(age: 30, email: "john@example.com", phone: "1234567890", title: "Mr.")
    assert_difference('Info.count', -1) do
      user.destroy
    end
  end

  test "accepts nested attributes for info" do
    user = User.new(name: "John Doe", info_attributes: { age: 30, email: "john@example.com", phone: "1234567890", title: "Mr." })
    assert user.save
    assert user.info.present?
    assert_equal 30, user.info.age
    assert_equal "john@example.com", user.info.email
  end
end