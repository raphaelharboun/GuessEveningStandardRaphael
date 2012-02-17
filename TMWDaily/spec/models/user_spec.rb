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
			@headlines = @dev.get_last_ten_headlines
			@headlines.count.should == 10
		end


	end


end
