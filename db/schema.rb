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

ActiveRecord::Schema.define(version: 2019_11_01_003933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "product_id"
    t.index ["category_id", "product_id"], name: "index_categories_products_on_category_id_and_product_id", unique: true
    t.index ["category_id"], name: "index_categories_products_on_category_id"
    t.index ["product_id"], name: "index_categories_products_on_product_id"
  end

  create_table "category_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.boolean "shipped", default: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "order_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "email"
    t.string "owling_address"
    t.string "name"
    t.string "cc_num"
    t.string "cc_exp_mo"
    t.string "cc_exp_yr"
    t.integer "cc_cvv"
    t.integer "zip_code"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_on_cc"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "stock"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wizard_id"
    t.boolean "retired", default: false
    t.integer "price_cents"
    t.index ["wizard_id"], name: "index_products_on_wizard_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.string "review_comment"
    t.index ["product_id"], name: "index_reviews_on_product_id"
  end

  create_table "wizards", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "uid"
    t.string "provider"
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "products", "wizards"
  add_foreign_key "reviews", "products"
end
