class ApplicationController < ActionController::Base

helper_method :current_username

  def current_username
    @current_username ||= Username.find(session[:username_id]) if session[:username_id]
  end

end
