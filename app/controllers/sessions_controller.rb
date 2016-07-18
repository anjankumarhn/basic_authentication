class SessionsController < ApplicationController

	def new
  end

  def create
    user = User.find_by_email(user_params[:email])
  	if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to users_path, :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password combination"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Logged out'
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end