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

ActiveRecord::Schema.define(:version => 20110131073505) do

  create_table "affiliate_merchants", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.text     "banner"
    t.integer  "category_id"
    t.integer  "affiliate_merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",              :default => false
  end

  add_index "listings", ["affiliate_merchant_id"], :name => "index_listings_on_affiliate_merchant_id"
  add_index "listings", ["category_id", "affiliate_merchant_id"], :name => "index_listings_on_category_id_and_affiliate_merchant_id"
  add_index "listings", ["category_id"], :name => "index_listings_on_category_id"

  create_table "pages", :force => true do |t|
    t.string   "reference"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",   :limit => 128
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "address"
    t.string   "paypal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "is_admin"
    t.string   "provider"
    t.string   "uid"
    t.string   "key"
    t.string   "name"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["key"], :name => "index_users_on_key", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
