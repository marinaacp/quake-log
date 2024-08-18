class RemoveDurationFromGames < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :duration
  end
end
