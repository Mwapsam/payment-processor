class PaymentMethod < ApplicationRecord
    has_one :fee, dependent: :destroy
    has_many :transactions, dependent: :destroy
    
    validates :payment_method_type, presence: true
    validates :payment_method_name, presence: true, uniqueness: true
    validates :fee_structure, presence: true

    has_one_attached :image
end
  