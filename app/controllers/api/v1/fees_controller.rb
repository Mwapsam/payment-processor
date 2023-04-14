class Api::V1::FeesController < ApplicationController
    before_action :set_fee, only: [:show, :update, :destroy]

    def index
      @fees = Fee.all
      render json: @fees
    end
  
    def show
      render json: @fee
    end
  
    def create
      @fee = Fee.new(fee_params)
      if @fee.save
        render json: @fee, status: :created
      else
        render json: @fee.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @fee.update(fee_params)
        render json: @fee
      else
        render json: @fee.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @fee.destroy
      head :no_content
    end
  
    private
  
    def set_fee
      @fee = Fee.find(params[:id])
    end
  
    def fee_params
      # params.require(:fee).permit(:name, :amount, :payment_method_id)
      params.permit(:transaction_amount, :fee_percentage, :payment_method_id)
    end
end
