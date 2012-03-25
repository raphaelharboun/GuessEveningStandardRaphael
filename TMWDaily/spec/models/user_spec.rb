require 'spec_helper'

describe User do

	describe "Using DevineUser" do

		before :each do
			@devine = Factory.build(:devineUser)
			@devine.skip_confirmation!
			@devine.save
			15.times do |i|
				headline = @devine.headlines.build :name => "Headline #{i+1}"
				headline.created_at = Headline.get_start_date + 1.hour - (i+1).day
				headline.save!
			end
			@devine.headlines.count.should == 15
		end

		it "should retrieve the last 10 evening standard headlines" do
			@dev = DevineUser.first
			@headlines = @dev.get_last_headlines 10
			@headlines.count.should == 10
		end


	end

	describe "User" do

		before :each do
			user = Factory.build(:user)
			user.skip_confirmation!
			user.save
			user.headlines.create :name => "Current Headline"
		end

		it "should have default type" do
			u = User.first
			u.type.should == "User"
		end	

		it "should get currentHeadline" do
			user = User.first
			user.has_current_headline?.should be_true
			user.headlines.current.first.name.should == "Current Headline"
		end

	end


end
