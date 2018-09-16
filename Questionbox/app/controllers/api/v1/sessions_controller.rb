class Api::V1::SessionsController < ApplicationController

  skip_before_action :verify_authentication

  def create
    username = Username.find_by_username(params[:username])

    if username && username.authenticate(params[:password])
      render json: { token: username.api_token }
    else
      render json: { error: "Invalid" }, status: :unauthorized
    end
  end

end