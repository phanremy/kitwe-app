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

ActiveRecord::Schema[7.0].define(version: 2023_08_05_084650) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "couples", force: :cascade do |t|
    t.bigint "profile1_id", null: false
    t.bigint "profile2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_couples_on_creator_id"
    t.index ["profile1_id", "profile2_id"], name: "index_couples_on_profile1_id_and_profile2_id", unique: true
    t.index ["profile1_id"], name: "index_couples_on_profile1_id"
    t.index ["profile2_id"], name: "index_couples_on_profile2_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "category"
    t.string "sub_category"
    t.string "privacy", default: "public", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id", null: false
    t.text "notes"
    t.index ["creator_id"], name: "index_events_on_creator_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_follows_on_profile_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.string "status", default: "requested", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "requester_id"
    t.bigint "addressee_id"
    t.bigint "specifier_id"
    t.index ["addressee_id"], name: "index_friendships_on_addressee_id"
    t.index ["requester_id"], name: "index_friendships_on_requester_id"
    t.index ["specifier_id"], name: "index_friendships_on_specifier_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "profile_events", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_profile_events_on_event_id"
    t.index ["profile_id"], name: "index_profile_events_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "pseudo"
    t.string "first_name"
    t.string "first_name_privacy", default: "public", null: false
    t.string "last_name"
    t.string "last_name_privacy", default: "public", null: false
    t.string "email"
    t.string "email_privacy", default: "public", null: false
    t.string "phone"
    t.string "phone_privacy", default: "public", null: false
    t.date "birth_date"
    t.string "birth_date_privacy", default: "public", null: false
    t.string "tiktok_url"
    t.string "twitter_url"
    t.string "linkedin_url"
    t.text "notes"
    t.string "address"
    t.string "address_privacy", default: "public", null: false
    t.date "wedding_date"
    t.string "wedding_date_privacy", default: "public", null: false
    t.string "kids"
    t.string "kids_privacy", default: "public", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id", null: false
    t.bigint "parents_id"
    t.string "category", default: ""
    t.string "photo_url"
    t.string "gender"
    t.index ["category"], name: "index_profiles_on_category"
    t.index ["creator_id"], name: "index_profiles_on_creator_id"
    t.index ["parents_id"], name: "index_profiles_on_parents_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "category"
    t.string "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.boolean "confirmed", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "couples", "profiles", column: "profile1_id"
  add_foreign_key "couples", "profiles", column: "profile2_id"
  add_foreign_key "couples", "users", column: "creator_id"
  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "follows", "profiles"
  add_foreign_key "follows", "users"
  add_foreign_key "friendships", "users", column: "addressee_id"
  add_foreign_key "friendships", "users", column: "requester_id"
  add_foreign_key "friendships", "users", column: "specifier_id"
  add_foreign_key "posts", "users"
  add_foreign_key "profile_events", "events"
  add_foreign_key "profile_events", "profiles"
  add_foreign_key "profiles", "couples", column: "parents_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "profiles", "users", column: "creator_id"
  add_foreign_key "tokens", "users"
end
