require 'test_helper'

class Api::GamesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @game = games(:game_one)
    @player = players(:player_one)
    @kill = kills(:kill_one)
  end

  test "should create game with valid file" do
    file = fixture_file_upload('qgames_test.log', 'text/plain')

    # Make sure the file upload is correct and is read properly
    assert file.present?

    post api_games_url, params: { file: file }

    assert_response :ok
    assert_equal 'File uploaded successfully', JSON.parse(response.body)['message']
  end

  test "should not create game with invalid file" do
    file = fixture_file_upload('pdf.pdf', 'application/pdf')

    post api_games_url, params: { file: file }

    assert_response :unprocessable_entity
    assert_equal 'Invalid file format', JSON.parse(response.body)['error']
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

end
