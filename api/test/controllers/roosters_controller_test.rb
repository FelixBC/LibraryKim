require "test_helper"

class RoostersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rooster = roosters(:one)
  end

  test "should get index" do
    get roosters_url, as: :json
    assert_response :success
  end

  test "should create rooster" do
    assert_difference("Rooster.count") do
      post roosters_url, params: { rooster: { agility: @rooster.agility, breed_id: @rooster.breed_id, color_id: @rooster.color_id, defence: @rooster.defence, loses: @rooster.loses, name: @rooster.name, owners_id: @rooster.owners_id, resistance: @rooster.resistance, strength: @rooster.strength, wins: @rooster.wins } }, as: :json
    end

    assert_response :created
  end

  test "should show rooster" do
    get rooster_url(@rooster), as: :json
    assert_response :success
  end

  test "should update rooster" do
    patch rooster_url(@rooster), params: { rooster: { agility: @rooster.agility, breed_id: @rooster.breed_id, color_id: @rooster.color_id, defence: @rooster.defence, loses: @rooster.loses, name: @rooster.name, owners_id: @rooster.owners_id, resistance: @rooster.resistance, strength: @rooster.strength, wins: @rooster.wins } }, as: :json
    assert_response :success
  end

  test "should destroy rooster" do
    assert_difference("Rooster.count", -1) do
      delete rooster_url(@rooster), as: :json
    end

    assert_response :no_content
  end
end
