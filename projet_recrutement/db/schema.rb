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

ActiveRecord::Schema.define(version: 20140116165557) do

  create_table "candidatures", force: true do |t|
    t.string   "candidature_pseudo"
    t.string   "candidature_mail"
    t.string   "candidature_motivation"
    t.date     "candidature_date"
    t.date     "candidature_bornDate"
    t.boolean  "candidature_result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.integer  "eval_mark"
    t.string   "eval_commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profils", force: true do |t|
    t.string   "profil_title"
    t.string   "profil_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "sess_title"
    t.date     "sess_beginDate"
    t.date     "sess_endDate"
    t.integer  "sess_state"
    t.string   "sess_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sess_status"
  end

  create_table "users", force: true do |t|
    t.string   "user_login"
    t.string   "user_pass"
    t.string   "user_mail"
    t.integer  "user_state"
    t.integer  "user_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
