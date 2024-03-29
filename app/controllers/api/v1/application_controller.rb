# frozen_string_literal: true

module Api
  module V1
    # This class handles authentication of user with cookies
    class ApplicationController < ActionController::API
      before_action :authenticate_user

      private

      def authenticate_user
        authorization_header = request.headers['Authorization']

        if authorization_header
          token = authorization_header.split[1]
          decoded_token = decode_token(token)
          user_id = decoded_token[0]['user_id']
          @current_user = User.find_by(id: user_id)

          # Validate the refresh token along with the access token
          # validate_refresh_token(request.headers['Refresh-Token']) if @current_user
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end

      def authorize_user
        authenticate_user || render_unauthorized
      end

      def render_unauthorized
        head :unauthorized
      end

      def decode_token(token)
        secret = ENV.fetch('jwt_secret_key', nil)

        begin
          JWT.decode(token, secret, true, algorithm: 'HS256')
        rescue StandardError => e
          render json: { error: 'Invalid token', status: :unprocessable_entity }
        end
      end

      attr_reader :current_user

      def validate_refresh_token(refresh_token)
        refresh_token_record = RefreshToken.find_by(token: refresh_token)

        if refresh_token_record &&
           refresh_token_record.user_id == @current_user.id &&
           refresh_token_record.expires_at > Time.zone.now
          # Refresh token is valid and has not expired, continue with the request

          # Generate a new refresh token
          new_refresh_token = generate_refresh_token(@current_user)

          # Optionally, you can also revoke the current refresh token if needed
          refresh_token_record.destroy

          # Return the new refresh token along with the response
          render json: { refresh_token: new_refresh_token }
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end

      def generate_access_token(user)
        secret = ENV.fetch('jwt_secret_key', nil)
        # JWT.encode({ user_id: user.id }, secret, 'HS256')

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
        expiration_time = 7.hours.from_now

        # Save the refresh token in the database, associating it with the user
        RefreshToken.create(user:, token: refresh_token, expires_at: expiration_time)

        refresh_token
      end
    end
  end
end
