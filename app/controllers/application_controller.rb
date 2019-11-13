class ApplicationController < ActionController::Base
	helper_method :current_user
  def current_user
    if session[:user_id]
      @current_user ||= Usuario.find(session[:user_id])
    else
      @current_user = nil
    end
  end
end
