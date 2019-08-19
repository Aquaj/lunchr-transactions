class Transaction < ApplicationRecord
  scope :earlier_than, -> (timestamp) { timestamp ? where("created_at < ?", timestamp) : all }
  scope :later_than, -> (timestamp) { timestamp ? where("created_at > ?", timestamp) : all }

  def initialize(model)
    @model = model
  end
end
