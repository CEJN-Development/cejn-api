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

ActiveRecord::Schema[7.0].define(version: 2022_06_11_152838) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowlisted_jwts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "jti", null: false
    t.string "aud", null: false
    t.datetime "exp", precision: nil, null: false
    t.string "remote_ip"
    t.string "os_data"
    t.string "browser_data"
    t.string "device_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "article_authors", force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "article_id"], name: "index_article_authors_on_author_id_and_article_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.text "sample"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.text "excerpt"
    t.string "cloudinary_image_url"
    t.string "caption"
    t.index ["slug"], name: "index_articles_on_slug"
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "events", force: :cascade do |t|
    t.datetime "date", precision: nil, null: false
    t.string "cloudinary_image_url"
    t.string "name", null: false
    t.string "slug"
    t.text "body"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_events_on_slug"
  end

  create_table "landing_pages", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "preview"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_landing_pages_on_slug"
  end

  create_table "organizations", force: :cascade do |t|
    t.text "blurb"
    t.text "body"
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cloudinary_image_url"
    t.index ["slug"], name: "index_organizations_on_slug"
  end

  create_table "press_releases", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "body"
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_press_releases_on_slug"
  end

  create_table "splash_sections", force: :cascade do |t|
    t.string "name", null: false
    t.integer "priority", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "full_name"
    t.string "short_name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "writers", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "slug", null: false
    t.text "byline"
    t.string "cloudinary_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_writers_on_slug"
  end

  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
end
