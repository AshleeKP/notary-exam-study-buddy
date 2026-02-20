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

ActiveRecord::Schema[7.0].define(version: 2026_02_20_202408) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_results", force: :cascade do |t|
    t.bigint "study_session_id", null: false
    t.bigint "card_id", null: false
    t.boolean "is_correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_results_on_card_id"
    t.index ["study_session_id"], name: "index_card_results_on_study_session_id"
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "pamphlet_version_id", null: false
    t.text "question"
    t.text "answer"
    t.string "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pamphlet_version_id"], name: "index_cards_on_pamphlet_version_id"
  end

  create_table "pamphlet_versions", force: :cascade do |t|
    t.integer "year"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "study_sessions", force: :cascade do |t|
    t.date "study_date"
    t.integer "cards_studied"
    t.integer "correct_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "card_results", "cards"
  add_foreign_key "card_results", "study_sessions"
  add_foreign_key "cards", "pamphlet_versions"
end
