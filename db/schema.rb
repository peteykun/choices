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

ActiveRecord::Schema.define(version: 20150403224944) do

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.integer  "answer",      limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "review",      limit: 1
  end

  create_table "config_tables", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "options", force: :cascade do |t|
    t.string   "body",        limit: 255
    t.integer  "question_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "correct",     limit: 1
  end

  create_table "questions", force: :cascade do |t|
    t.text     "body",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",          limit: 255
    t.integer  "question_type", limit: 4
    t.integer  "answer",        limit: 4
    t.integer  "subject_id",    limit: 4
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "college",         limit: 255
    t.string   "email",           limit: 255
    t.string   "phone",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
    t.string   "username",        limit: 255
    t.boolean  "is_admin",        limit: 1
    t.integer  "subject_id",      limit: 4
  end

end
