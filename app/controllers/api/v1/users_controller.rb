require 'JWT'

class Api::V1::UsersController < ApplicationController
  def index
    users = User.all

    render json: users
  end

  def create
    user = User.new(user_params)

    if user.save
      token = generate_token(user)
      render json: { token: token }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
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
    params.require(:user).permit(:name, :username, :email, :is_confirmed, :role, :last_seen, :password)
  end

  def generate_token(user)
    JWT.encode({ user_id: user.id }, Rails.application.credentials.jwt_secret_key, 'HS256')
  end
end
