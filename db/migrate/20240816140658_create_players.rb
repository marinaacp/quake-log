class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.references :game, null: false, foreign_key: true
      t.string :name, limit: 50, null: false
      t.string :model, limit: 20, null: false
      t.string :submodel, limit: 20
      t.integer :id_in_log, null: false
      t.integer :score

      t.timestamps
    end
  end
end
