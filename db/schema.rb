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

ActiveRecord::Schema.define(version: 20180704032503) do

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "approved",    default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "to_post"
    t.datetime "approved_at"
    t.datetime "posted_at"
    t.integer  "vote",        default: 0
    t.date     "post_date"
    t.string   "title",       default: "Title"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                    null: false
    t.string   "encrypted_password",     default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.text     "image",                  default: "default-profile.jpg"
    t.boolean  "admin",                  default: false
    t.string   "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vote_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "positive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "post_id"], name: "index_vote_relationships_on_user_id_and_post_id", unique: true
  end

end
