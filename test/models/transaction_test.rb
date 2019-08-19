require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  setup do
    @payment = CardPayment.create!(
      merchant_name: "CardMerchant",
      amount_cents: 1345
    )

    @credit = MealVoucherCredit.create!(
      company_name: "MealVoucherCompany",
      amount_cents: 29000
    )

    @order = RestoOrder.create!(
      resto_name: "OrderResto",
      amount_cents: 1350
    )
  end

  test 'it groups the contents of RestoOrder, CardPayment and MealVoucherCredit' do
    assert_equal Transaction.count, 3

    order_transaction = Transaction.find_by(transaction_type: 'resto_order',
                                            id: @order.id)
    assert order_transaction.present?
    assert_equal @order.resto_name, order_transaction.name
    assert_equal @order.amount_cents, order_transaction.amount_cents

    credit_transaction = Transaction.find_by(transaction_type: 'meal_voucher_credit',
                                             id: @order.id)
    assert credit_transaction.present?
    assert_equal @credit.company_name, credit_transaction.name
    assert_equal @credit.amount_cents, credit_transaction.amount_cents

    payment_transaction = Transaction.find_by(transaction_type: 'card_payment',
                                              id: @payment.id)
    assert payment_transaction.present?
    assert_equal @payment.merchant_name, payment_transaction.name
    assert_equal @payment.amount_cents, payment_transaction.amount_cents
  end
end
