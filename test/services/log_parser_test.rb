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
    last_game = Game.last
    penultimate_game = Game.order(:id).reverse_order.offset(1).first

    expected_last_game = Game.new(
      gametype: 4,
      fraglimit: 15,
      timelimit: 10,
      capturelimit: 5
    )
    expected_penultimate_game = Game.new(
      gametype: 0,
      fraglimit: 20,
      timelimit: 15,
      capturelimit: 8
    )

    assert_equal expected_last_game.attributes.except("id"), last_game.attributes.except("id")
    assert_equal expected_penultimate_game.attributes.except("id"), penultimate_game.attributes.except("id")
  end

  test 'should parse log and create players' do
    @parser.parse
    game = Game.last
    assert_equal 3, game.players.count
  end

  test 'should create palyers with expected attributes' do
    @parser.parse
    last_player = Player.last
    penultimate_player = Player.order(:id).reverse_order.offset(1).first

    expected_last_player = Player.new(
      game_id: Game.last.id,
      name: "Zeh",
      model: "sarge",
      submodel: "default",
      id_in_log: 4,
      score: 20
    )
    expected_penultimate_player = Player.new(
      game_id: Game.last.id,
      name: "Jim",
      model: "uriel",
      submodel: "zael",
      id_in_log: 3,
      score: -4
    )

    excluded_attributes = %w[id created_at updated_at]

    assert_equal expected_last_player.attributes.except(*excluded_attributes), last_player.attributes.except(*excluded_attributes)
    assert_equal expected_penultimate_player.attributes.except(*excluded_attributes), penultimate_player.attributes.except(*excluded_attributes)
  end

  test 'should parse log and create kills' do
    @parser.parse
    game = Game.last
    assert_equal 4, game.kills.count
  end

  test 'should create kills with expected attributes' do
    @parser.parse
    last_kill = Kill.last
    player_kill = Kill.order(:id).reverse_order.offset(3).first

    expected_last_kill = Kill.new(
      killer_id: nil,
      victim_id: Player.order(:id).reverse_order.offset(2).first.id,
      type_death: 19,
      is_world_death: true
    )
    expected_player_kill = Kill.new(
      killer_id: Player.order(:id).reverse_order.offset(1).first.id,
      victim_id: Player.order(:id).reverse_order.offset(2).first.id,
      type_death: 6,
      is_world_death: false
    )

    assert_equal expected_last_kill.attributes.except("id"), last_kill.attributes.except("id")
    assert_equal expected_player_kill.attributes.except("id"), player_kill.attributes.except("id")
  end

  test 'should not create any kills if there are no kill events' do
    @parser.parse
    game = Game.order(:id).reverse_order.offset(2).first

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
    file = file_fixture('empty.log')
    parser = LogParserService.new(file)

    assert_no_difference('Game.count') do
      assert_no_difference('Player.count') do
        assert_no_difference('Kill.count') do
          parser.parse
        end
      end
    end

  end

end
