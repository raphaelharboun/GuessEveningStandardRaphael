FactoryGirl.define do
	factory :user do
		email "raphaelharboun@gmail.com"
		password "strauss"
		password_confirmation "strauss"
	end

	factory :headline do
		name "new headline"
	end
	
end