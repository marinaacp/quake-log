class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.integer :gametype, null: false
      t.integer :fraglimit, null: false
      t.integer :timelimit, null: false # in seconds
      t.integer :capturelimit
      t.integer :duration, null: false # in seconds
    end
  end
end
