class Api::V1::PaymentMethodsController < ApplicationController
    before_action :set_payment_method, only: [:show, :update, :destroy]

    def index
      @payment_methods = PaymentMethod.all
      render json: @payment_methods
    end
  
    def show
      render json: @payment_method
    end
  
    def create
      @payment_method = PaymentMethod.new(payment_method_params)
      if @payment_method.save
        render json: @payment_method, status: :created
      else
        render json: @payment_method.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @payment_method.update(payment_method_params)
        render json: @payment_method
      else
        render json: @payment_method.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @payment_method.destroy
      head :no_content
    end
  
    private
  
    def set_payment_method
      @payment_method = PaymentMethod.find(params[:id])
    end
  
    def payment_method_params
      # params.require(:payment_method).permit(:name, :description)
      params.permit(:payment_method_name, :payment_method_type, :fee_structure, :image)
    end
end
