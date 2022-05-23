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

ActiveRecord::Schema[7.0].define(version: 2022_05_23_130706) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accepted_bids", force: :cascade do |t|
    t.decimal "pay"
    t.text "notes"
    t.bigint "post_id", null: false
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
    t.datetime "original_bid_created", precision: nil
    t.datetime "original_bid_updated", precision: nil
    t.index ["post_id"], name: "index_accepted_bids_on_post_id"
    t.index ["username"], name: "index_accepted_bids_on_username"
  end

  create_table "bids", force: :cascade do |t|
    t.decimal "pay", precision: 10, scale: 2, default: "0.0"
    t.text "notes", default: ""
    t.bigint "post_id", null: false
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.string "hash_id"
    t.index ["post_id"], name: "index_bids_on_post_id"
    t.index ["username"], name: "index_bids_on_username"
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.text "notification_references", default: [], array: true
    t.jsonb "data", default: {}
    t.integer "notification_type"
    t.boolean "read", default: false
    t.index ["username"], name: "index_notifications_on_username"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "post_links", force: :cascade do |t|
    t.string "domain"
    t.string "path"
    t.string "post_marker"
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_links_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", default: "New Post"
    t.decimal "pay", default: "0.0"
    t.boolean "closed", default: false
    t.text "description", default: "New Description"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start", default: "2022-01-28 11:42:25", null: false
    t.string "hash_id"
    t.index ["username"], name: "index_posts_on_username"
  end

  create_table "rejected_bids", force: :cascade do |t|
    t.decimal "pay"
    t.text "notes"
    t.bigint "post_id", null: false
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
    t.datetime "original_bid_created", precision: nil
    t.datetime "original_bid_updated", precision: nil
    t.index ["post_id"], name: "index_rejected_bids_on_post_id"
    t.index ["username"], name: "index_rejected_bids_on_username"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accepted_bids", "posts"
  add_foreign_key "bids", "posts"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "post_links", "posts"
  add_foreign_key "rejected_bids", "posts"
end
