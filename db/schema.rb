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

ActiveRecord::Schema.define(:version => 20130308200041) do

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.integer  "problem_id"
    t.integer  "group_id"
    t.date     "due_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "assignments", ["group_id"], :name => "index_assignments_on_group_id"
  add_index "assignments", ["problem_id"], :name => "index_assignments_on_problem_id"

  create_table "attempts", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.string   "outcome"
    t.string   "language"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "code"
  end

  add_index "attempts", ["problem_id"], :name => "index_attempts_on_problem_id"
  add_index "attempts", ["user_id"], :name => "index_attempts_on_user_id"

  create_table "cases", :force => true do |t|
    t.text     "input"
    t.text     "output"
    t.integer  "problem_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cases", ["problem_id"], :name => "index_cases_on_problem_id"

  create_table "commands", :force => true do |t|
    t.string   "name"
    t.string   "compile_command"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "enrollments", ["group_id"], :name => "index_enrollments_on_group_id"
  add_index "enrollments", ["user_id"], :name => "index_enrollments_on_user_id"

  create_table "feedbacks", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "line_number"
    t.string   "comment"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "feedbacks", ["problem_id"], :name => "index_feedbacks_on_problem_id"

  create_table "groups", :force => true do |t|
    t.integer  "subject_id"
    t.string   "period"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "groups", ["subject_id"], :name => "index_groups_on_subject_id"

  create_table "problems", :force => true do |t|
    t.float    "time"
    t.boolean  "module"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.text     "main",       :limit => 255
    t.text     "method",     :limit => 255
    t.string   "language"
    t.integer  "user_id"
    t.string   "dificulty"
    t.integer  "command_id"
  end

  create_table "problems_topics", :id => false, :force => true do |t|
    t.integer "problem_id", :null => false
    t.integer "topic_id",   :null => false
  end

  add_index "problems_topics", ["problem_id", "topic_id"], :name => "index_problems_topics_on_problem_id_and_topic_id"
  add_index "problems_topics", ["topic_id", "problem_id"], :name => "index_problems_topics_on_topic_id_and_problem_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "texts", :force => true do |t|
    t.string   "textable_type"
    t.integer  "textable_id"
    t.string   "text_identifier"
    t.text     "text_content"
    t.string   "locale"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "num"
    t.string   "name"
    t.string   "lastname"
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "teacher",                :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
