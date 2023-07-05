class Api::V1::AnalyticsController < ApplicationController
    before_action :authenticate_user, only: [:transactions]
  
    def transactions
      user = User.find(params[:user_id])
      transactions = user.transactions
      successful_transactions = transactions.where(transaction_status: "SUCCESSFUL").count
  
      render json: {
        daily_transactions: user.daily_transactions.count,
        weekly_transactions: user.weekly_transactions.count,
        total_transactions: user.total_transactions,
        successful_transactions: successful_transactions,
        transactions: transactions
      }
    end
end
  