require 'spec_helper'

describe Headline do

	it "shouldn't save an empty headline" do
		@headline = Headline.new
		expect { @headline.save! }.to raise_error
	end

	it "shouldn't save a headline without a user" do
		@headline = Factory.build(:headline)
		@headline.should_not be_valid
	end

	describe "Using User" do

		before :each do
			@user = Factory.build(:user)
			@user.skip_confirmation!
			@user.save
		end

		it "shouldn't save multiple headline for 1 user the same day" do
			@user.headlines.build :name => "first headline"
			@user.save
			@headline = @user.headlines.build :name => "second headline"
			@headline.should_not be_valid
		end
	
		it "should extract 3+ letters tags from headline" do
			@headline = @user.headlines.build :name => "This is a new Headline"
			@tags = @headline.extract_tags
			@tags.count.should == 3
			@tags.should include("This", "new", "Headline") 
		end

	end

	describe "User mutliple users" do

		before :each do
			15.times do |i|
				user = Factory.build(:user)
				user.skip_confirmation!
				user.save
				user.headlines.build :name => "Headline"
				user.save 
			end
		end

		it "should get 10 headlines randomly" do
			@headlines = Headline.get_ten_random_current_headline
			@headlines.count.should == 10
		end


	end
	
end
