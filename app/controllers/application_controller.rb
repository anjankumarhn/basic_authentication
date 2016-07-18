class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  def require_session
  	if session[:user_id].present?
  	  @current_user = User.find(session[:user_id])
  	else
  		flash[:error] = "Need to login"
  		redirect_to root_path
  	end
  end
end
