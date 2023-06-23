require "test_helper"

class OwnersCreateControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:one)
  end

  test "should get index" do
    get owners_url, as: :json
    assert_response :success
  end

  test "should create owner" do
    assert_difference("OwnersCreate.count") do
      post owners_url, params: { owner: { age: @owner.age, city: @owner.city, identification_number: @owner.identification_number, loses: @owner.loses, name: @owner.name, phone: @owner.phone, wins: @owner.wins } }, as: :json
    end

    assert_response :created
  end

  test "should show owner" do
    get owner_url(@owner), as: :json
    assert_response :success
  end

  test "should update owner" do
    patch owner_url(@owner), params: { owner: { age: @owner.age, city: @owner.city, identification_number: @owner.identification_number, loses: @owner.loses, name: @owner.name, phone: @owner.phone, wins: @owner.wins } }, as: :json
    assert_response :success
  end

  test "should destroy owner" do
    assert_difference("OwnersCreate.count", -1) do
      delete owner_url(@owner), as: :json
    end

    assert_response :no_content
  end
end
