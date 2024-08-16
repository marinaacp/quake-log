# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_16_143901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "gametype", null: false
    t.integer "fraglimit", null: false
    t.integer "timelimit", null: false
    t.integer "capturelimit"
    t.integer "duration", null: false
  end

  create_table "kills", force: :cascade do |t|
    t.bigint "killer_id", null: false
    t.bigint "victim_id", null: false
    t.integer "type_death", null: false
    t.boolean "is_world_death", default: false, null: false
    t.index ["killer_id"], name: "index_kills_on_killer_id"
    t.index ["victim_id"], name: "index_kills_on_victim_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "name", limit: 50, null: false
    t.string "model", limit: 20, null: false
    t.string "submodel", limit: 20
    t.integer "id_in_log", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  add_foreign_key "kills", "players", column: "killer_id"
  add_foreign_key "kills", "players", column: "victim_id"
  add_foreign_key "players", "games"
end
