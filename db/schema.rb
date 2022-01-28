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

ActiveRecord::Schema.define(version: 2022_01_28_120353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.decimal "pay", precision: 10, scale: 2, default: "0.0"
    t.text "notes", default: ""
    t.bigint "post_id", null: false
    t.string "owner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "accepted", default: false
    t.index ["post_id"], name: "index_bids_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", default: "New Post"
    t.decimal "pay", default: "0.0"
    t.boolean "closed", default: false
    t.text "description", default: "New Description"
    t.string "owner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start", precision: 6, default: "2022-01-28 11:42:25", null: false
  end

  create_table "rejected_bids", force: :cascade do |t|
    t.decimal "pay"
    t.text "notes"
    t.bigint "post_id", null: false
    t.string "owner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_rejected_bids_on_post_id"
  end

  add_foreign_key "bids", "posts"
  add_foreign_key "rejected_bids", "posts"
end
