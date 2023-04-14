class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(phone_number: params[:phone_number])

    if user && user.authenticate(params[:password])
      token = issue_token(user)
      set_token_cookie(token)
      response.headers['Access-Control-Allow-Origin'] = 'http://127.0.0.1:5173'
      response.headers['Access-Control-Allow-Credentials'] = 'true'
      render json: { user: user }, status: :ok
    else
      render json: { error: 'Invalid phone number or password' }, status: :unauthorized
    end
  end

  def destroy
    delete_token_cookie
    response.headers['Access-Control-Allow-Origin'] = 'http://127.0.0.1:5173'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
