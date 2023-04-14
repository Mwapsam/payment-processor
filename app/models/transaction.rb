class Transaction < ApplicationRecord
    belongs_to :user
    belongs_to :payment_method
    validates :transaction_status, presence: true
    validates :transaction_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :transaction_id, presence: true, uniqueness: true
    validates :transaction_timestamp, presence: true
end
  