FactoryGirl.define do

	sequence :email do |n|
		"raphael#{n}@gmail.com"
	end

	factory :user do
		email { Factory.next(:email) }
		password "strauss"
		password_confirmation "strauss"
	end

	factory :devineUser do
		email "devine@gmail.com"
		password "strauss"
		password_confirmation "strauss"
	end

	factory :headline do
		name "new headline"
	end
	
end