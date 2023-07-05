class Api::V1::CustomersController < ApplicationController
    before_action :authenticate_user
    
    def index
      users = User.all
      customers = users.map do |user|
        { 
          user: user,
          profile: user.profile,
          id_card_url: url_for(user.profile.id_card),
          selfie_url: url_for(user.profile.selfie)
        }
      end
      render json: customers
    end
end
  