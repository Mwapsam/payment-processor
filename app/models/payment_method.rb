class PaymentMethod < ApplicationRecord
    has_many :transactions
    validates :payment_method_type, presence: true
    validates :payment_method_name, presence: true, uniqueness: true
    validates :fee_structure, presence: true
end
  