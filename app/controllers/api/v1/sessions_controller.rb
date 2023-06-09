class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def encode_token(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, Rails.application.credentials.jwt_secret_key, 'HS256')
  end
end
