# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to user
    class UsersController < Api::V1::ApplicationController
      before_action :authenticate_user, only: %i[index me]
      include ActionController::Cookies

      def index
        users = User.all

        render json: users
      end

      def create
        user = User.new(user_params.merge(password: params[:password]))

        if user.save
          access_token = generate_access_token(user)
          refresh_token = generate_refresh_token(user)
          render json: { access_token:, refresh_token: }
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def me
        user = User.find(@current_user.id)

        if user
          render json: user
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def logout
        expiration = 1.second.ago
        set_cookie(:access_token, '', expiration)
        set_cookie(:refresh_token, '', expiration)

        render json: { status: 200 }
      end

      def update
        User.find(params[:id])
        user = User.update(user_params)

        render json: user
      end

      def destroy
        user = User.find(params[:id])
        user.destroy

        render json: "#{user.id} is deleted"
      end

      private

      def user_params
        params.require(:user).permit(:name, :username, :email, :is_confirmed, :role, :last_seen, :password_digest)
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
    end
  end
end
