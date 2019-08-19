require 'test_helper'

class TransactionsControllerControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = CardPayment.create!(
      merchant_name: "CardMerchant",
      amount_cents: 1345,
      created_at: 3.second.ago
    )

    @credit = MealVoucherCredit.create!(
      company_name: "MealVoucherCompany",
      amount_cents: 29000,
      created_at: 2.second.ago
    )

    @order = RestoOrder.create!(
      resto_name: "OrderResto",
      amount_cents: 1350,
      created_at: 1.second.ago
    )
  end

  test "should get index" do
    get transactions_controller_index_url
    assert_response :success
  end

  test "should be paginated" do
    get transactions_url, params: { limit: 2 }

    assert_response :success
    json_response = JSON(response.body)
    assert_equal 2, json_response.length

    order = json_response.first
    assert order.present?
    assert_equal order['name'], @order.resto_name
    assert_equal order['amount_cents'], @order.amount_cents

    credit = json_response.second
    assert credit.present?
    assert_equal credit['name'], @credit.company_name
    assert_equal credit['amount_cents'], @credit.amount_cents

    get transactions_url, params: { limit: 2, latest_timestamp: @credit.created_at }

    assert_response :success
    json_response = JSON(response.body)
    assert_equal 1, json_response.length

    payment = json_response.first
    assert payment.present?
    assert_equal payment['name'], @payment.merchant_name
    assert_equal payment['amount_cents'], @payment.amount_cents
  end
end
