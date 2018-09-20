class Api::UsersController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :destroy, :update]

  def index
    @users = User.all
    render json: @users
  end

  def new
    @users = User.new
    render json: @users
  end
  
  def create
    @user = User.new(users_params)
    if @user.save
    render json: @user
    else
      render json: {"error": "Invalid"}, status: :unprocessable_entity
    end
  end

  def show
    @user = @user.id
    render json: @user
  end

  def destroy
    if api_token_user.id == @user.id
      @user.destroy
      render json: {"notice": "User has been deleted."}, status: :accepted
    else
      render json: {"error": "You do not have permission to delete this user."}, status: :unprocessable_entity
    end
  end

  def update
    if api_token_user.id == @user.id
      @user.update(user_params)
      render :profile, status: :updated, location: api_profile_path
    else
      render json: {"error": "You do not have permission to update this user."}, status: :unauthorized
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def users_params
      params.permit(:user, :password)
    end
end