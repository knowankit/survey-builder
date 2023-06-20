class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      access_token = generate_access_token(user)
      refresh_token = generate_refresh_token(user)

      render json: { access_token: access_token, refresh_token: refresh_token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_access_token(user)
    secret = ENV['jwt_secret_key']

    # Set the expiration time for the access token
    expiration_time = Time.now.to_i + 3600 # One hour from now

    # Generate a new access token using the user's information
    access_token_payload = {
      user_id: user.id,
      exp: expiration_time
    }

    # Sign the access token using a secret key
    access_token = JWT.encode(access_token_payload, secret, 'HS256')

    access_token
  end

  def generate_refresh_token(user)
    # Generate a new refresh token using a secure random token generator
    refresh_token = SecureRandom.base58(32)

    # Set the expiration time for the refresh token
    expiration_time = Time.now + 2.hour
    # Save the refresh token in the database, associating it with the user
    RefreshToken.create(user: user, token: refresh_token, expires_at: expiration_time)

    refresh_token
  end

end
