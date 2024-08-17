require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  setup do
    @player = players(:player_one)
  end

  test "should be valid with valid attributes" do
    assert @player.valid?
  end

  test "should require name, model, and id_in_log" do
    @player.name = nil
    assert_not @player.valid?
    assert_includes @player.errors[:name], "can't be blank"

    @player.model = nil
    assert_not @player.valid?
    assert_includes @player.errors[:model], "can't be blank"

    @player.id_in_log = nil
    assert_not @player.valid?
    assert_includes @player.errors[:id_in_log], "can't be blank"
  end

  test "should belong to game" do
    assert_respond_to @player, :game
  end

  test "should have many kills as killer" do
    assert_respond_to @player, :kills_as_killer
  end

  test "should have many kills as victim" do
    assert_respond_to @player, :kills_as_victim
  end
end
