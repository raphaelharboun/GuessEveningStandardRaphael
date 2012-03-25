class User < ActiveRecord::Base
	has_many :headlines
	scope :standard, where(:type => 'User')
	scope :devine, where(:type => 'DevineUser')
	scope :current, lambda { joins(:headlines).where("headlines.created_at >= ?", Headline.get_start_date) }

 	 # Include default devise modules. Others available are:
 	 # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
 	 devise :database_authenticatable, :registerable,
 	        :recoverable, :rememberable, :trackable, :validatable,
 	        :confirmable
	
 	 # Setup accessible (or protected) attributes for your model
 	 attr_accessible :email, :password, :password_confirmation, :remember_me, :type

 	 def has_current_headline?
 	 	!headlines.current.empty?
 	 end
end




 