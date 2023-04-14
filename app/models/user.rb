class User < ApplicationRecord
    has_many :transactions
    has_many :projects
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone_number, presence: true, uniqueness: { case_sensitive: true }
    validates :account_balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    has_secure_password
end
  
