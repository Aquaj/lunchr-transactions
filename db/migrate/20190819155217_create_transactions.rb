class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_view :transactions
  end
end
