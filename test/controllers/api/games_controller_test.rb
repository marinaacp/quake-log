require 'test_helper'

class Api::GamesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @game = games(:game_one)
    @player = players(:player_one)
    @kill = kills(:kill_one)
  end

  test "should create game with valid file" do
    file = fixture_file_upload('qgames_test.log', 'text/plain')

    post api_games_url, params: { file: file }

    assert_response :ok
    assert_includes JSON.parse(response.body)['message'], 'File uploaded successfully'
  end

  test "should not create game with invalid file" do
    file = fixture_file_upload('pdf.pdf', 'application/pdf')

    post api_games_url, params: { file: file }

    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)['error'], 'Invalid file format'
  end

  test "should get index" do
    get api_games_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response
    assert_not_empty json_response
  end

  test "should show game" do
    get api_game_url(@game), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @game.id, json_response['id']
    assert json_response['game_data']
  end

  test "should get kills_by_means" do
    get api_kills_by_means_url
    assert_response :success
    json_response = JSON.parse(@response.body)

    # Assert that the JSON structure is correct
    assert json_response.key?("game-#{@game.id}")
    assert json_response["game-#{@game.id}"].key?("kills_by_means")

    # Assert that the kills_by_means data is correct
    expected_kills_by_means = @game.kills_by_means
    assert_equal expected_kills_by_means, json_response["game-#{@game.id}"]["kills_by_means"]
  end

end
