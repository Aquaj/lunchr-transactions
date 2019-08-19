# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CardPayment.create!(
  merchant_name: "CardMerchant",
  amount_cents: 1345
)

MealVoucherCredit.create!(
  company_name: "MealVoucherCompany",
  amount_cents: 29000
)

RestoOrder.create!(
  resto_name: "OrderResto",
  amount_cents: 1350
)
