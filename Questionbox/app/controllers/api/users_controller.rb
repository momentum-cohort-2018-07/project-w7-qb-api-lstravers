class Api::UsersController < ApplicationController
  
  skip_before_action :verify_authentication, only: [:create], raise: false
  before_action :set_user, only: [:show, :destroy, :update]

  def index
    @users = User.all
    render json: @users
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
    render json: @user
    else
      render json: {"error": "Invalid"}, status: :unprocessable_entity
    end
  end

def destroy
  @user.destroy
end
  
  private
    def users_params
      params.permit(:user, :password)
    end
end