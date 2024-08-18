require "test_helper"

class KillTest < ActiveSupport::TestCase
  setup do
    @kill = kills(:kill_one)
  end

  test "should be valid with valid attributes" do
    assert @kill.valid?
  end

  test "should require victim_id and type_death" do
    @kill.victim_id = nil
    assert_not @kill.valid?
    assert_includes @kill.errors[:victim_id], "can't be blank"
    
    @kill.type_death = nil
    assert_not @kill.valid?
    assert_includes @kill.errors[:type_death], "can't be blank"
  end

  test "should belong to killer" do
    assert_respond_to @kill, :killer
  end

  test "should belong to victim" do
    assert_respond_to @kill, :victim
  end
end
