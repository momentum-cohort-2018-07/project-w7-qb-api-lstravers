class ApplicationController < ActionController::Base

  before_action :verify_authenticity_token
  helper_method :current_user
  helper_method :api_token_user
  
  def verify_authentication
    unless api_token_user
      render json: {error: "You do not have permission."}, status: :unauthorized
    end
  end

  protected

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def api_token_user
      @api_token_user ||= authenticate_with_http_token do |token, options|
        User.find_by_api_token(token)
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end