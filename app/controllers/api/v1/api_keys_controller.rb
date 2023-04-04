class Api::V1::ApiKeysController < ApplicationController
    include ApiKeyAuthenticatable
    include ActionController::HttpAuthentication::Basic::ControllerMethods # add this line
    
    # Require API key authentication
    prepend_before_action :authenticate_with_api_key!, only: %i[index destroy]
  
    def index
      render json: current_bearer.api_keys
    end
  
    def create
      authenticate_with_http_basic do |phone_number, password|
        user = User.find_by phone_number: phone_number
  
        if user&.authenticate(password)
          api_key = user.api_keys.create! token: SecureRandom.hex
  
          render json: api_key, status: :created and return
        end
      end
  
      render status: :unauthorized
    end
  
    def destroy
      api_key = current_bearer.api_keys.find(params[:id])
  
      api_key.destroy
    end
end
  