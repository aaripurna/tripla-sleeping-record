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

ActiveRecord::Schema[8.0].define(version: 2024_12_04_110300) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clock_in_summaries", force: :cascade do |t|
    t.date "schedule_date", null: false
    t.integer "user_id", null: false
    t.integer "sleep_duration_minute"
    t.datetime "sleep_start"
    t.datetime "sleep_end"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "schedule_date"], name: "index_clock_in_summaries_on_user_id_and_schedule_date", unique: true
  end

  create_table "clock_ins", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "event_time", null: false
    t.integer "event_type", null: false
    t.date "schedule_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "schedule_date", "event_type"], name: "index_clock_ins_on_user_id_and_schedule_date_and_event_type", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "followee_id"], name: "index_follows_on_follower_id_and_followee_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
