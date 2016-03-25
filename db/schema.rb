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

ActiveRecord::Schema.define(version: 20160321014330) do

  create_table "auditoria", force: :cascade do |t|
    t.integer  "number"
    t.integer  "seat_count"
    t.integer  "theater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "credit_card_type"
    t.integer  "credit_card_number"
    t.datetime "card_expiration"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "managers", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "synopsis"
    t.float    "runtime"
    t.string   "image"
    t.boolean  "placed?",       default: false
    t.integer  "auditorium_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "orders", force: :cascade do |t|
    t.float    "number_tickets_bought"
    t.float    "total_price"
    t.integer  "movie_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "showings", force: :cascade do |t|
    t.string   "time_string"
    t.float    "military_time"
    t.integer  "movie_id"
    t.boolean  "sold_out?",     default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "theaters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.float    "price"
    t.integer  "showing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
