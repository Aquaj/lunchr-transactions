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

ActiveRecord::Schema.define(version: 2019_08_19_155217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_payments", force: :cascade do |t|
    t.string "merchant_name"
    t.integer "amount_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_voucher_credits", force: :cascade do |t|
    t.string "company_name"
    t.integer "amount_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resto_orders", force: :cascade do |t|
    t.string "resto_name"
    t.integer "amount_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end


  create_view "transactions", sql_definition: <<-SQL
      SELECT transactions_union.id,
      transactions_union.transaction_type,
      transactions_union.name,
      transactions_union.amount_cents,
      transactions_union.created_at,
      transactions_union.updated_at
     FROM ( SELECT card_payments.id,
              'card_payment'::text AS transaction_type,
              card_payments.merchant_name AS name,
              card_payments.amount_cents,
              card_payments.created_at,
              card_payments.updated_at
             FROM card_payments
          UNION ALL
           SELECT meal_voucher_credits.id,
              'meal_voucher_credit'::text AS transaction_type,
              meal_voucher_credits.company_name AS name,
              meal_voucher_credits.amount_cents,
              meal_voucher_credits.created_at,
              meal_voucher_credits.updated_at
             FROM meal_voucher_credits
          UNION ALL
           SELECT resto_orders.id,
              'resto_order'::text AS transaction_type,
              resto_orders.resto_name AS name,
              resto_orders.amount_cents,
              resto_orders.created_at,
              resto_orders.updated_at
             FROM resto_orders) transactions_union;
  SQL
end
