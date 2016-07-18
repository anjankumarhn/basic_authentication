class User < ActiveRecord::Base

	has_secure_password

	#Validations
	 validates :name, presence: true, :length =>{ :minimum => 2, :maximum => 16 }
	 validates :email, :presence => true, :length => {:minimum => 3, :maximum => 254}
	 validates_uniqueness_of :email
     validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	 validates :password, presence: true, :length =>{ :minimum => 6, :maximum => 16 }
	 validates :password_confirmation, presence: true, confirmation: true

end
