class ApplicationController < ActionController::API
  include ActionController::Cookies
  include JwtHelper

  private

  def authenticate_user
    if token && user_id(token)
      @current_user ||= User.find_by(id: user_id(token))
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def authenticate_project
    project_api_key = request.headers['X-API-Key']
    @current_project ||= Project.find_by(api_key: project_api_key)
    if @current_project.nil?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def token
    cookies.signed[:jwt] || request.headers['Authorization']
  end

  def set_token_cookie(token)
    cookies.signed[:jwt] = {
      value: token,
      httponly: true,
      expires: Time.at(decoded_token(token).first['exp']),
      secure: Rails.env.production?,
      same_site: :none
    }
  end

  def delete_token_cookie
    cookies.delete(:jwt)
  end

  def jwt_key
    Rails.application.secrets.secret_key_base
  end
end