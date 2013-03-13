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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130210032508) do

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "state",                  :default => 0
    t.datetime "scheduled_at"
    t.datetime "invites_sent_at"
    t.datetime "opened_registration_at"
    t.string   "eventbrite_event_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "email",                :default => "", :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "github_id"
    t.string   "github_identifier"
    t.string   "authentication_token"
  end

  add_index "users", ["github_id"], :name => "index_users_on_github_id", :unique => true

end
