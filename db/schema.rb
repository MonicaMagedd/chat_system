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

ActiveRecord::Schema.define(version: 2022_10_01_191821) do

  create_table "applications", charset: "latin1", force: :cascade do |t|
    t.string "access_token"
    t.string "name"
    t.integer "chats_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_token"], name: "index_applications_on_access_token"
  end

  create_table "chats", charset: "latin1", force: :cascade do |t|
    t.integer "number"
    t.bigint "application_id"
    t.integer "messages_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_chats_on_application_id"
    t.index ["number"], name: "index_chats_on_number"
  end

  create_table "messages", charset: "latin1", force: :cascade do |t|
    t.integer "number"
    t.text "body"
    t.bigint "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["number"], name: "index_messages_on_number"
  end

  add_foreign_key "chats", "applications"
  add_foreign_key "messages", "chats"
end
