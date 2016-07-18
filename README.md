# Basic sign up and sign in logics in Rails
Configured postgres database and added bcrypt for password secure:

```ruby
gem 'pg'
gem 'bcrypt-ruby'
gem 'bcrypt'
```
Run the following command to install the gems:

```
bundle install
```

Create a user table migration with the respective columns and their type:

```ruby
bundle exec rails g model user name:string email:string password_digest:string auth_token:string
```

Run the following command to migrate to database:

```
bundle exec rake db:migrate
```

Create a controller users and add a new and create action for sign up action

```
bundle exec rails g controller users
```

Create routes for the users by adding following in config/routes.rb

```
resources :users
```

Add a new action and create a object in the users controller

```
def new
	@user = User.new
end
```

Create a new folder users under apps/views & add a new.html.erb template for form

Create a server side validation for User columns in User model.

```
validates :name, presence: true, :length =>{ :minimum => 2, :maximum => 16 }
validates :email, :presence => true, :length => {:minimum => 3, :maximum => 254}
validates_uniqueness_of :email
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
validates :password, presence: true, :length =>{ :minimum => 6, :maximum => 16 }
validates :password_confirmation, presence: true, confirmation: true
```

Added a create action to users controller

```
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
```

Added a filter for index action in users controller

```
before_filter :require_session, :only => [:index]
```
Added filter action in application_contoller.rb
```
def require_session
  	if session[:user_id].present?
  	  @current_user = User.find(session[:user_id])
  	else
  		flash[:error] = "Need to login"
  		redirect_to new_users_path
  	end
 end
```

Create a session controller for sign in

Create a session routes only for new, create & destroy in config/routes.rb

```
resources :sessions, :only => [:new, :create, :destroy]
```

Added a new, create & destroy action in sessions controller

Create a sign in form in sessions new template app/views/sessions/new

Make the sign in path as the root

```
root :to => "sessions#new"
```

Write a session create logic inside a sessions/create action

```
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
```

Write a logout logic in sessions/destroy action

```
def destroy
   reset_session
   redirect_to root_path, notice: 'Logged out'
end
```

# The main logics are 
Sign In logics are in sessions controller and views

Sign Up logics are in users controller and views

Filter in application controller

#Contributor

[Facebook][1]

[Twitter][2]

[Linkedin][3]

[About Me][4]

[1]: https://www.facebook.com/anjan.gowdamandya
[2]: https://twitter.com/aknagaraja
[3]: https://in.linkedin.com/in/anjankumar-h-n-882166b8
[4]: https://about.me/AnjanGowda
