require "test_helper"

class ReservationSpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation_space = reservation_spaces(:one)
  end

  test "should get index" do
    get reservation_spaces_url, as: :json
    assert_response :success
  end

  test "should create reservation_space" do
    assert_difference("ReservationSpace.count") do
      post reservation_spaces_url, params: { reservation_space: { availability: @reservation_space.availability, capacity: @reservation_space.capacity, name: @reservation_space.name } }, as: :json
    end

    assert_response :created
  end

  test "should show reservation_space" do
    get reservation_space_url(@reservation_space), as: :json
    assert_response :success
  end

  test "should update reservation_space" do
    patch reservation_space_url(@reservation_space), params: { reservation_space: { availability: @reservation_space.availability, capacity: @reservation_space.capacity, name: @reservation_space.name } }, as: :json
    assert_response :success
  end

  test "should destroy reservation_space" do
    assert_difference("ReservationSpace.count", -1) do
      delete reservation_space_url(@reservation_space), as: :json
    end

    assert_response :no_content
  end
end
