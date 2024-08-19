require 'test_helper'

class Api::PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:player_one)
  end

  test "should get player index" do
    get api_players_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response
    assert_not_empty json_response
  end

  test "should show player" do
    get api_player_url(@player), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @player.id, json_response['id']
    assert json_response['kills_data']
  end
end
