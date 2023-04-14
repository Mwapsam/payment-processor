class Fee < ApplicationRecord
    belongs_to :payment_method
    validates :transaction_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :fee_percentage, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
  