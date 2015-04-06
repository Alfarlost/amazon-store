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

ActiveRecord::Schema.define(version: 20150405115833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "state"
    t.string   "adress"
    t.string   "zipcode"
    t.string   "city"
    t.string   "phone"
    t.string   "country"
    t.string   "type"
    t.boolean  "same"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
    t.integer  "order_id"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id", using: :btree
  add_index "addresses", ["order_id"], name: "index_addresses_on_order_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "password"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",             precision: 8, scale: 2
    t.integer  "bookinstock"
    t.integer  "author_id"
    t.integer  "category_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "state"
    t.string   "avatar"
    t.string   "image"
    t.text     "small_description"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id", using: :btree
  add_index "books", ["category_id"], name: "index_books_on_category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "cvv"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "customer_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "order_id"
  end

  add_index "credit_cards", ["customer_id"], name: "index_credit_cards_on_customer_id", using: :btree
  add_index "credit_cards", ["order_id"], name: "index_credit_cards_on_order_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "password"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree

  create_table "discounts", force: :cascade do |t|
    t.string   "coupone_code"
    t.float    "discount"
    t.integer  "order_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "orderitems", force: :cascade do |t|
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "book_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.decimal  "unit_price", precision: 8, scale: 2
  end

  add_index "orderitems", ["book_id"], name: "index_orderitems_on_book_id", using: :btree
  add_index "orderitems", ["order_id"], name: "index_orderitems_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.decimal  "total_price",                  precision: 8, scale: 2
    t.datetime "completed_data"
    t.string   "state"
    t.integer  "customer_id"
    t.integer  "credit_card_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "coupone_code"
    t.integer  "delivery"
    t.decimal  "total_price_without_discount", precision: 8, scale: 2
    t.decimal  "total_price_with_discount",    precision: 8, scale: 2
  end

  add_index "orders", ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.text     "review"
    t.integer  "rating"
    t.integer  "customer_id"
    t.integer  "book_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "aasm_state"
  end

  add_index "ratings", ["book_id"], name: "index_ratings_on_book_id", using: :btree
  add_index "ratings", ["customer_id"], name: "index_ratings_on_customer_id", using: :btree

end
