class Transaction < ApplicationRecord
  def initialize(model)
    @model = model
  end
end
