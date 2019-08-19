class TransactionsController < ApplicationController
  def index
    @matching_records = scope.earlier_than(query_params[:latest_timestamp])
                             .limit(query_params[:limit])
    render json: @matching_records
  end

  private

  def scope
    Transaction.order(created_at: :desc)
  end

  def query_params
    params.permit(:limit, :latest_timestamp)
  end
end
