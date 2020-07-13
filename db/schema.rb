# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_13_014216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meals", force: :cascade do |t|
    t.integer "vendor_id"
    t.string "name"
    t.string "desc"
    t.integer "rating", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", precision: 10, scale: 2
    t.string "sample_alt"
    t.integer "discount"
    t.string "tag", default: "featured", null: false
    t.boolean "available", default: true, null: false
    t.string "sample", default: "https://i.ibb.co/VDvgFQs/download.png", null: false
    t.index ["vendor_id"], name: "index_meals_on_vendor_id"
  end

  create_table "order_records", force: :cascade do |t|
    t.integer "meal_id"
    t.integer "servings", default: 1, null: false
    t.bigint "order_id"
    t.index ["order_id"], name: "index_order_records_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "vendor_id"
    t.integer "user_id"
    t.string "location"
    t.string "payment_method"
    t.boolean "paid", default: false, null: false
    t.boolean "dispatched", default: false, null: false
    t.boolean "delivered", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price"
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["vendor_id"], name: "index_orders_on_vendor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "phone_number"
    t.string "location"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "vendorname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "phone_number"
    t.integer "rating", default: 0
    t.string "company_name"
    t.string "company_branch"
    t.string "location", default: "Abuja", null: false
    t.string "address", default: "", null: false
    t.string "logo", default: "https://i.ibb.co/rfN873y/247-2476490-food-vendor-icon-hd-png-download.png", null: false
    t.index ["company_name", "company_branch"], name: "index_vendors_on_company_name_and_company_branch", unique: true
  end

  add_foreign_key "meals", "vendors"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "vendors"
end
