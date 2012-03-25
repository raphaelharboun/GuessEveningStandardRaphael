ActiveAdmin.register User do

	filter :email
	filter :last_sign_in_at
	filter :created_at

	scope :all
	scope :standard, :default => true
	scope :devine
	scope :current

	index do
		column :id
		column :email
		column "headlines" do |user|
			link_to "#{user.headlines.count} headlines", admin_user_path(user)
		end
		column :type
	end

	show :title => :email do
		panel "current headline" do
			if user.has_current_headline?
				attributes_table_for user.headlines.current.first do
					row("name") { |headline| link_to "#{headline.name}", admin_headline_path(headline) }
					row :created_at
				end
			else
				"no current headline"
			end
		end
		panel "history" do
			table_for(user.headlines.history) do
				column :id
				column("headline") { |headline| link_to "#{headline.name}", admin_headline_path(headline) }
				column :created_at
			end
		end
	end

	sidebar "User details", :only => :show do
		attributes_table_for user, :id, :email, :sign_in_count, :last_sign_in_at, :type
	end

	sidebar "Statistics", :only => :show do
		attributes_table_for user do
			row("headlines count") {user.headlines.count}
		end
	end

	form do |f|
		f.inputs "User details" do
			f.input :email 
			f.input :password
			f.input :password_confirmation
			f.input :type, :as => :radio, :collection => ['User', 'DevineUser']
		end
		f.buttons
	end
	

end
