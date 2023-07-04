# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      before_action :authenticate_user, only: [:index]

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
    end
  end
end
