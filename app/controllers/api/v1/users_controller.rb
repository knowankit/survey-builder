class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :authenticate_user, only: [:index]

  def index
    users = User.all

    render json: users
  end

  def create
    user = User.new(user_params.merge(password: params[:password]))

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
    params.require(:user).permit(:name, :username, :email, :is_confirmed, :role, :last_seen, :password_digest)
  end

  def generate_token(user)
    secret = ENV['jwt_secret_key']
    JWT.encode({ user_id: user.id }, secret, 'HS256')
  end
end
