require "test_helper"

class InfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @info = infos(:one)
    @user = users(:eight)
  end

  test "should get index" do
    get "/infos.json"

    assert_response :ok
    assert_equal Info.count, json_response["total_infos"]
    assert_equal 1, json_response["page"]
    assert_equal 10, json_response["per_page"]
    assert_operator json_response["infos"].size, :>, 1
  end

  test "should create info" do
    assert_difference("Info.count") do
      post "/infos.json", params: { info: { age: @info.age, email: @info.email, phone: @info.phone, title: @info.title, user_id: @user.id } }
    end

    assert_response :created
    assert_equal json_response["title"], @info.title
    assert_equal json_response["email"], @info.email
    assert_equal json_response["age"], @info.age
    assert_equal json_response["user"]["id"], @user.id
    assert_equal json_response["user"]["name"], @user.name
  end

  test "should not create info" do
    post "/infos.json", params: { info: { age: @info.age, email: "wrong@email", phone: @info.phone, title: @info.title, user_id: @user.id } }

    assert_response :unprocessable_entity
    assert_includes json_response["errors"], "Email is invalid"
  end

  test "should show info" do
    get "/infos/#{@info.id}.json"

    assert_response :ok
    assert_equal json_response["title"], @info.title
    assert_equal json_response["email"], @info.email
    assert_equal json_response["age"], @info.age
    assert_equal json_response["user"]["name"], @info.user.name
    assert_equal json_response["user"]["id"], @info.user.id
  end

  test "should show not found" do
    get "/infos/1.json"

    assert_response :not_found
    assert_equal json_response["message"], "Info not found"
  end

  test "should update info" do
    put "/infos/#{@info.id}.json", params: { info: { title: "MR.", age: 30, email: "testmail@example.com" } }

    assert_response :ok
    assert_equal json_response["title"], "MR."
    assert_equal json_response["email"], "testmail@example.com"
    assert_equal json_response["age"], 30
  end

  test "should destroy info" do
    assert_difference("Info.count", -1) do
      delete "/infos/#{@info.id}.json"
    end

    assert_response :ok
    assert_equal json_response["message"], "Info was successfully deleted"
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
