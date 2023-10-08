# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :username)
  end
end
