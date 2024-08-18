require "test_helper"

class GameTest < ActiveSupport::TestCase
  setup do
    @game = games(:game_one)
  end

  test "should be valid with valid attributes" do
    assert @game.valid?
  end

  test "should require gametype, fraglimit, timelimit, and duration" do
    @game.gametype = nil
    assert_not @game.valid?
    assert_includes @game.errors[:gametype], "can't be blank"

    @game.fraglimit = nil
    assert_not @game.valid?
    assert_includes @game.errors[:fraglimit], "can't be blank"

    @game.timelimit = nil
    assert_not @game.valid?
    assert_includes @game.errors[:timelimit], "can't be blank"
  end

  test "should have many players" do
    assert_respond_to @game, :players
  end

  test "should have many kills through players" do
    assert_respond_to @game, :kills
  end
end
