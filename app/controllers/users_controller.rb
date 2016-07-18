class UsersController < ApplicationController

	 before_filter :require_session, :only => [:index]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.valid?
			@user.save!
			flash[:success] = "User signed up succssfully!"
			session[:user_id] = @user.id
			redirect_to users_path
		else
			flash[:error] = @user.errors.full_messages
			render :new
		end
	end

	def index
		@users = User.all
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end