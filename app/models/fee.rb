class Fee < ApplicationRecord
    belongs_to :payment_method

    validates :payment_method_id, uniqueness: true
    validates :fee_percentage, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
