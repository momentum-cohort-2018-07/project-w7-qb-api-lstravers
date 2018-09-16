class Api::V1::UsernamesController < ApplicationController
  skip_before_action :verify_authentication

  def index
    @usernames = Username.all
    render json: @usernames
  end
  
  def create
    username = Username.new(usernames_params)
    if username.save
      render json: username, status: :ok # or 200
    else
      render json: username.errors, status: :bad_request # or 400
    end
  end

    # DELETE /username/1
    def destroy
      @username.destroy
    end
  
  private
    def usernames_params
      params.permit(:username, :password)
    end

end