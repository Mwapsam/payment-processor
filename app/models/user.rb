class User < ApplicationRecord
    has_many :transactions, dependent: :destroy
    has_many :projects, dependent: :destroy
    has_one :profile, dependent: :destroy
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone_number, presence: true, uniqueness: { case_sensitive: true }
    validates :account_balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    has_secure_password
  
    def update_balance(amount)
      self.account_balance += amount
      save
    end
  
    def daily_transactions
      transactions.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
  
    def weekly_transactions
      transactions.where(created_at: 1.week.ago..Time.zone.now.end_of_day)
    end
  
    def total_transactions
      transactions.count
    end
end
  