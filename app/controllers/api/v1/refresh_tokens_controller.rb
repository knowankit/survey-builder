class Api::V1::RefreshTokensController < Api::V1::ApplicationController
  def create
    refresh_token = RefreshToken.find_by(token: params[:refresh_token])

    if refresh_token && refresh_token.user
      # Generate a new access token for the user
      access_token = generate_access_token(refresh_token.user)
      refresh_token.destroy

      render json: { access_token: }
    else
      render json: { error: 'Invalid refresh token' }, status: :unauthorized
    end
  end

  def destroy
    refresh_token = RefreshToken.find_by(token: params[:refresh_token])
    refresh_token.destroy if refresh_token

    head :no_content
  end
end
