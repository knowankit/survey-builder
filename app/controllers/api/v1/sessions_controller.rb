# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to user session during login
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user, only: :create
      include ActionController::Cookies

      def create
        user = find_user

        if authenticated?(user)
          access_token = generate_access_token(user)
          # refresh_token = generate_refresh_token(user)

          access_token_cookie(access_token)
          # refresh_token_cookie(refresh_token)

          render json: { access_token: }
        else
          render_unauthorized_error
        end
      end

      private

      def find_user
        user =  User.find_by(email: params[:login])
        user ||= User.find_by(username: params[:login])
        user
      end

      def authenticated?(user)
        user&.authenticate(params[:password])
      end

      def access_token_cookie(token)
        set_cookie(:access_token, token, 1.hour.from_now)
      end

      def refresh_token_cookie(token)
        set_cookie(:refresh_token, token, 7.days.from_now)
      end

      def set_cookie(name, value, expiration)
        cookies[name] = {
          value:,
          expires: expiration,
          secure: Rails.env.production?,
          httpOnly: true,
          same_site: :strict,
          domain: Rails.env.production? ? '.knowankit.com' : :all
        }
      end

      def generate_access_token(user)
        secret = ENV.fetch('jwt_secret_key', nil)
        expiration_time = Time.now.to_i + 3600

        access_token_payload = {
          user_id: user.id,
          exp: expiration_time
        }

        JWT.encode(access_token_payload, secret, 'HS256')
      end

      def generate_refresh_token(user)
        refresh_token = SecureRandom.base58(32)
        expiration_time = 7.days.from_now

        RefreshToken.create(user:, token: refresh_token, expires_at: expiration_time)

        refresh_token
      end

      def render_unauthorized_error
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
end
