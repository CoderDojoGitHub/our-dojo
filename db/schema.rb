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

ActiveRecord::Schema.define(:version => 20140227064245) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "event_subscribers", :force => true do |t|
    t.string   "email"
    t.integer  "event_id"
    t.datetime "sent_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.datetime "start_time",              :null => false
    t.datetime "end_time"
    t.string   "teacher_github_username", :null => false
    t.integer  "lesson_id",               :null => false
    t.string   "location",                :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "class_size"
  end

  create_table "lessons", :force => true do |t|
    t.string   "title",                  :null => false
    t.text     "summary",                :null => false
    t.string   "image_url"
    t.string   "repository",             :null => false
    t.string   "author_github_username"
    t.text     "events_attributes"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "registrants", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrations", :force => true do |t|
    t.integer  "registrant_id",             :null => false
    t.integer  "number_of_students",        :null => false
    t.integer  "event_id",                  :null => false
    t.string   "reference_token",           :null => false
    t.datetime "created_at",                :null => false
    t.datetime "temporary_registration_at", :null => false
  end

  create_table "temporary_registrations", :force => true do |t|
    t.integer  "registrant_id",      :null => false
    t.integer  "number_of_students", :null => false
    t.integer  "event_id",           :null => false
    t.string   "reference_token",    :null => false
    t.datetime "created_at",         :null => false
  end

  add_index "temporary_registrations", ["reference_token"], :name => "index_temporary_registrations_on_reference_token", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "email",                :default => "", :null => false
    t.integer  "github_id"
    t.string   "github_identifier"
    t.string   "authentication_token"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "users", ["github_id"], :name => "index_users_on_github_id", :unique => true

end
