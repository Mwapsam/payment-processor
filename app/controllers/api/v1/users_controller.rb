class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user, only: [:index]

    def index
        users = User.all
        render json: users, status: 201
    end

    def create
        user = User.new(user_params)
    
        if user.save
          token = issue_token(user)
          render json: { user: user, jwt: token}
    
        elsif user.errors.messages
          render json: { errors: user.errors.messages }
        else
          render json: { error: 'User could not be created.' }
        end
    end
    
    private

    def user_params
        # params.require(:user).permit(:name, :phone_number, :email, :password)
        params.permit(:name, :phone_number, :email, :password)
    end
end
