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
      payment_method = PaymentMethod.find_by(id: fee_params[:payment_method_id])
      @fee = payment_method.fee
    
      if @fee.nil?
        @fee = payment_method.create_fee(fee_params)
      else
        @fee.update(fee_params)
      end
    
      if @fee.persisted?
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
      params.require(:fee).permit(:fee_percentage, :payment_method_id)
    end    
end
