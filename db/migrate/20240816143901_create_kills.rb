class CreateKills < ActiveRecord::Migration[7.1]
  def change
    create_table :kills do |t|
      t.references :killer, foreign_key: { to_table: :players }
      t.references :victim, foreign_key: { to_table: :players }, null: false
      t.integer :type_death, null: false
      t.boolean :is_world_death, default: false, null: false
    end
  end
end
