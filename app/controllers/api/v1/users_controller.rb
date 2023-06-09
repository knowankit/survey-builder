class Api::V1::UsersController < ApplicationController
  def index
    users = User.all

    render json: users
  end

  def create
    user = User.new(name: params[:name], username: params[:username], email: params[:email], is_confirmed: params[:is_confirmed], role: params[:role], last_seen: params[:last_seen], password: params[:password_digest])

    if user.save
      render json: user
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
    params.require(:user).permit(:name, :username, :email, :is_confirmed, :role, :last_seen, :password_digest)
  end
end
