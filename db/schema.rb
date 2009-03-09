# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090308080542) do

  create_table "limit_scopes", :force => true do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.integer  "key_meta_id"
    t.string   "prefix"
    t.string   "op"
    t.integer  "value_meta_id"
    t.string   "value"
    t.string   "suffix"
    t.string   "logic"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metas", :force => true do |t|
    t.string   "obj"
    t.string   "key"
    t.string   "name"
    t.integer  "kind_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permission_metas", :force => true do |t|
    t.integer  "permission_id"
    t.integer  "meta_id"
    t.string   "include"
    t.string   "joins"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.boolean  "public"
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_roles", :force => true do |t|
    t.integer  "permission_id"
    t.integer  "role_id"
    t.boolean  "granted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "name"
    t.string   "email"
    t.string   "remark"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
