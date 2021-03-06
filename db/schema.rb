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

ActiveRecord::Schema.define(version: 20141212073450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "question_inputs", force: true do |t|
    t.integer "question_id"
    t.integer "value"
    t.string  "label"
    t.string  "meta_label"
    t.string  "helper"
  end

  create_table "questions", force: true do |t|
    t.string   "catalog"
    t.string   "name"
    t.string   "group"
    t.string   "kind"
    t.integer  "section"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["name"], name: "index_questions_on_name", unique: true, using: :btree

  create_table "symptoms", force: true do |t|
    t.string "name",             limit: 50
    t.string "language",         limit: 2
    t.text   "related_catalogs",            default: [], array: true
  end

  add_index "symptoms", ["name"], name: "index_symptoms_on_name", unique: true, using: :btree

  create_table "user_symptoms", force: true do |t|
    t.integer "user_id"
    t.integer "symptom_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
    t.integer  "weight"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.text     "catalogs",               default: [],              array: true
    t.integer  "symptoms_count"
    t.text     "active_symptoms",        default: [],              array: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
