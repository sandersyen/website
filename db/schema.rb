# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181019214247) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "group_id"
    t.string "name"
    t.datetime "time"
    t.text "location"
    t.integer "time_poll_id"
    t.integer "location_poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_events_on_group_id"
    t.index ["location_poll_id"], name: "index_events_on_location_poll_id"
    t.index ["time_poll_id"], name: "index_events_on_time_poll_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_groups_on_category_id"
  end

  create_table "poll_options", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_poll_options_on_poll_id"
  end

  create_table "polls", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_time"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "google_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
