require 'test_helper'

class LogParserTest < ActiveSupport::TestCase
  def setup
    @file = file_fixture('qgames_test.log')
    @parser = LogParserService.new(@file)
  end

  test 'should parse log and create games' do
    assert_difference('Game.count', 3) do
      @parser.parse
    end
  end

  test 'should create games with expected attributes' do
    @parser.parse
    first_game = Game.first
    second_game = Game.second

    expected_first_game = Game.new(
      gametype: 0,
      fraglimit: 20,
      timelimit: 15,
      capturelimit: 8
    )
    expected_second_game = Game.new(
      gametype: 0,
      fraglimit: 20,
      timelimit: 15,
      capturelimit: 8
    )

    assert_equal expected_first_game.attributes, first_game.attributes
    assert_equal expected_second_game.attributes, second_game.attributes
  end

  test 'should parse log and create players' do
    @parser.parse
    game = Game.last
    assert_equal 3, game.players.count
  end

  test 'should create palyers with expected attributes' do
    @parser.parse
    second_player = Player.second
    third_player = Player.third

    expected_second_player = Player.new(
      game_id: 2,
      name: "Isgalamido",
      model: "uriel",
      submodel: "zael",
      id_in_log: 2,
      score: nil
    )
    expected_third_player = Player.new(
      game_id: 2,
      name: "Mocinha",
      model: "sarge",
      submodel: nil,
      id_in_log: 3,
      score: nil
    )

    assert_equal expected_second_player.attributes, second_player.attributes
    assert_equal expected_third_player.attributes, third_player.attributes
  end

  test 'should parse log and create kills' do
    @parser.parse
    game = Game.last
    assert_equal 4, game.kills.count
  end

  test 'should create kills with expected attributes' do
    @parser.parse
    first_kill = Kill.first
    fourth_kill = Kill.fourth

    expected_first_kill = Kill.new(
      killer_id: nil,
      victim_id: 2,
      type_death: 22,
      is_world_death: true
    )
    expected_fourth_kill = Kill.new(
      killer_id: 2,
      victim_id: 3,
      type_death: 7,
      is_world_death: false
    )

    assert_equal expected_first_kill.attributes, first_kill.attributes
    assert_equal expected_fourth_kill.attributes, fourth_kill.attributes
  end

  test 'should not create any kills if there are no kill events' do
    @parser.parse
    game = Game.first

    assert_equal 0, game.kills.count
  end

  test 'should not create any game if there is no client connection' do
    file = file_fixture('qgames_empty_test.log')
    parser = LogParserService.new(file)

    assert_difference('Game.count', 0) do
      parser.parse
    end
  end

  test 'should not create any records if the log file is empty' do
    empty_log_file = StringIO.new('')
    parser = LogParserService.new(empty_log_file)

    assert_no_difference('Game.count') do
      assert_no_difference('Player.count') do
        assert_no_difference('Kill.count') do
          parser.parse
        end
      end
    end

  end

end
