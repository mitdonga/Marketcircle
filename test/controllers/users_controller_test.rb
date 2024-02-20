require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get "/users.json"
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal User.count, json_response["total_users"]
    assert_equal 1, json_response["page"]
    assert_equal 10, json_response["per_page"]
    assert_operator json_response["users"].size, :>, 1
  end

  test "should create user" do
    assert_difference("User.count") do
      post "/users.json", params: { user: { name: @user.name } }
    end
    json_response = JSON.parse(response.body)

    assert_response :created
    assert_equal json_response["name"], @user.name
  end

  test "should not create user" do
    post "/users.json", params: { user: { name: "" } }
    json_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert_includes json_response["errors"], "Name can't be blank"
  end

  test "should show user" do
    get "/users/#{@user.id}.json"
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal json_response["name"], @user.name
  end

  test "should update user" do
    put "/users/#{@user.id}.json", params: { user: { name: "Meet Donga" } }
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal json_response["name"], "Meet Donga"
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete "/users/#{@user.id}.json"
    end
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal json_response["message"], "User was successfully deleted"
  end
end
