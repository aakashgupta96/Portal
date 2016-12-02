# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161202153504) do

  create_table "bidders_projects", id: false, force: :cascade do |t|
    t.integer "bidder_id",         null: false
    t.integer "bidded_project_id", null: false
  end

  add_index "bidders_projects", ["bidded_project_id", "bidder_id"], name: "index_bidders_projects_on_bidded_project_id_and_bidder_id"
  add_index "bidders_projects", ["bidder_id", "bidded_project_id"], name: "index_bidders_projects_on_bidder_id_and_bidded_project_id"

  create_table "posters_posts", id: false, force: :cascade do |t|
    t.integer "poster_id", null: false
    t.integer "post_id",   null: false
  end

  add_index "posters_posts", ["post_id", "poster_id"], name: "index_posters_posts_on_post_id_and_poster_id"
  add_index "posters_posts", ["poster_id", "post_id"], name: "index_posters_posts_on_poster_id_and_post_id"

  create_table "projects", force: :cascade do |t|
    t.string   "budget"
    t.string   "description"
    t.string   "avgbig"
    t.string   "time"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "title"
    t.integer  "poster_id"
    t.boolean  "completed",   default: false
    t.integer  "employee_id"
    t.integer  "finisher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "contact_no",             default: "", null: false
    t.float    "employee_ratings"
    t.float    "employer_ratings"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
