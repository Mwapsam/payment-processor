class Api::V1::ProfilesController < ApplicationController
    before_action :authenticate_user
    before_action :set_profile, only: [:show, :update, :destroy]
  
    def index
      @profile = @current_user.profile
      render json: @profile, serializer: ProfileSerializer
    end
  
    def show
      render json: @profile, serializer: ProfileSerializer
    end
  
    def create
        @profile = @current_user.profile
    
        if @profile.nil?
          @profile = Profile.new(profile_params)
          @profile.user = @current_user

          if @profile.save
            render json: @profile, status: :created
          else
            render json: @profile.errors.full_messages.to_sentence, status: :unprocessable_entity
          end
        else
          if @profile.update(profile_params)
            render json: @profile, status: :ok
          else
            render json: @profile.errors.full_messages.to_sentence, status: :unprocessable_entity
          end
        end
    end
  
    def update
      if @profile.update(profile_params)
        render json: @profile, serializer: ProfileSerializer
      else
        render json: { errors: @profile.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @profile.destroy
      head :no_content
    end
  
    private
  
    def set_profile
      @profile = @current_user.profile
    end
  
    def profile_params
        params.require(:profile).permit(:full_name, :address, :phone_number, :user_id, :email, :tpin, :business_name, :selfie, :id_card, :latitude, :longitude)
    end
end
  