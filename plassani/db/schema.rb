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

ActiveRecord::Schema.define(version: 20140124203749) do

  create_table "candidatures", force: true do |t|
    t.string   "pseudo"
    t.string   "mail"
    t.string   "motivation"
    t.date     "submitDate"
    t.date     "bornDate"
    t.string   "result"
    t.integer  "id_session"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.integer  "mark"
    t.string   "commentary"
    t.integer  "id_candidature"
    t.integer  "id_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profils", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "title"
    t.date     "beginDate"
    t.date     "endDate"
    t.string   "state"
    t.string   "description"
    t.integer  "id_profil"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "pass"
    t.string   "mail"
    t.string   "state"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
