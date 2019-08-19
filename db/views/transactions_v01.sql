SELECT id, transaction_type, name, amount_cents, created_at, updated_at
  FROM (
    SELECT id,
           'card_payment' AS transaction_type,
           merchant_name AS name,
           amount_cents,
           created_at,
           updated_at
      FROM card_payments
  UNION ALL (
    SELECT id,
           'meal_voucher_credit' AS transaction_type,
           company_name AS name,
           amount_cents,
           created_at,
           updated_at
      FROM meal_voucher_credits
  )
  UNION ALL (
    SELECT id,
           'resto_order' AS transaction_type,
           resto_name AS name,
           amount_cents,
           created_at,
           updated_at
      FROM resto_orders
  )
) AS transactions_union;

