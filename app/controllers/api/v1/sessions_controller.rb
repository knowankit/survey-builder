# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      include ActionController::Cookies

      def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          access_token = generate_access_token(user)
          refresh_token = generate_refresh_token(user)

          cookies[:access_token] = {
            value: access_token,
            expires: 1.hour.from_now,
            secure: Rails.env.production?,
            httpOnly: Rails.env.production?,
            same_site: :strict
          }

          # Set the refresh token in the cookie
          cookies[:refresh_token] = {
            value: refresh_token,
            expires: 7.days.from_now,
            secure: Rails.env.production?,
            httpOnly: Rails.env.production?,
            same_site: :strict
          }

          render json: { access_token:, refresh_token: }
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      private

      def generate_access_token(user)
        secret = ENV.fetch('jwt_secret_key', nil)

        # Set the expiration time for the access token
        expiration_time = Time.now.to_i + 3600 # One hour from now

        # Generate a new access token using the user's information
        access_token_payload = {
          user_id: user.id,
          exp: expiration_time
        }

        # Sign the access token using a secret key
        JWT.encode(access_token_payload, secret, 'HS256')
      end

      def generate_refresh_token(user)
        # Generate a new refresh token using a secure random token generator
        refresh_token = SecureRandom.base58(32)

        # Set the expiration time for the refresh token
        expiration_time = 7.days.from_now
        # Save the refresh token in the database, associating it with the user
        RefreshToken.create(user:, token: refresh_token, expires_at: expiration_time)

        refresh_token
      end
    end
  end
end
