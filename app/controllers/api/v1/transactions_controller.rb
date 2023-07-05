require 'json'

class Api::V1::TransactionsController < ApplicationController
  include MomoApiHelper
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    @transactions = Transaction.all
    render json: @transactions
  end

  def show
    render json: @transaction
  end

  def create
    trans_id = SecureRandom.uuid.to_s
    payment_method = PaymentMethod.find(transaction_params[:payment_method_id])
    amount = calculate_amount_with_fee(transaction_params[:transaction_amount].to_f, payment_method)
    trans = get_token(amount, "EUR", trans_id, transaction_params[:phone_number])
    trans_json = JSON.parse(trans)
  
    @transaction = Transaction.new(transaction_params)
    @transaction.transaction_status = trans_json["status"]
    @transaction.transaction_id = trans_id
    @transaction.transaction_timestamp = Time.now
    @transaction.service_charge = amount - transaction_params[:transaction_amount].to_f
  
    if @transaction.save
      @transaction.user.update_balance(transaction_params[:transaction_amount].to_f)
      render json: { transaction: @transaction, trans: trans }, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
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
    params.require(:transaction).permit(:user_id, :payment_method_id, :transaction_amount, :phone_number)
  end

  def calculate_amount_with_fee(amount, payment_method)
    fee = payment_method.fees.find_by(payment_method_id: payment_method.id)
    fee_percentage = fee.fee_percentage.to_f
    fee_amount = amount * (fee_percentage / 100.0)
    (amount + fee_amount).round(2)
  end
end
