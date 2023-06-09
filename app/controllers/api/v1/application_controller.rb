class ApplicationController < ActionController::API
  before_action :authenticate_user

  private

  def authenticate_user
    authorization_header = request.headers['Authorization']

    if authorization_header
      token = authorization_header.split(' ')[1]
      decoded_token = decode_token(token)
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.jwt_secret_key, true, algorithm: 'HS256')
  end

  def current_user
    @current_user
  end
end
