class Api::V1::TransactionsController < ApplicationController
    include MomoApiHelper
    before_action :authenticate_project
    before_action :set_transaction, only: [:show, :update, :destroy]

    def index
      @transactions = Transaction.all
      render json: @transactions
    end
  
    def show
      render json: @transaction
    end
  
    def create
      amount = calculate_amount_with_fee(transaction_params[:transaction_amount].to_f)
      trans = get_token(amount, "EUR", transaction_params[:transaction_id], "0780123456")
    
      @transaction = Transaction.new(transaction_params)
      if @transaction.save
        render json: { transaction: @transaction, trans: trans }, status: :created
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
    
    def calculate_amount_with_fee(amount)
      fee = 5.0 / 100.0
      return (amount * (1.0 + fee)).round(2)
    end    
  
    def update
      if @transaction.update(transaction_params)
        render json: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @transaction.destroy
      head :no_content
    end
  
    private
  
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
  
    def transaction_params
      # params.require(:transaction).permit(:user_id, :payment_method_id, :transaction_status, :transaction_amount, :transaction_id, :transaction_timestamp)
      params.permit(:user_id, :payment_method_id, :transaction_status, :transaction_amount, :transaction_id, :transaction_timestamp)
    end
end
