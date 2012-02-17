class User < ActiveRecord::Base
	has_many :headlines

 	 # Include default devise modules. Others available are:
 	 # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
 	 devise :database_authenticatable, :registerable,
 	        :recoverable, :rememberable, :trackable, :validatable,
 	        :confirmable
	
 	 # Setup accessible (or protected) attributes for your model
 	 attr_accessible :email, :password, :password_confirmation, :remember_me
end


class DevineUser < User

	def get_last_ten_headlines
		headlines.order("created_at DESC").limit(10).select("name, created_at")
	end

end

 