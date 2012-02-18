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
			@headline = @user.headlines.build :name => "This is a New Headline"
			@tags = @headline.extract_tags
			@tags.count.should == 3
			@tags.should include("This", "New", "Headline") 
		end

		it "should create 3+ letters tags if not exists and put the counter at 1" do
			@headline = @user.headlines.create :name => "THIS is a new headline"
			@tags = @headline.tags.current
			@tags.count.should == 3
			@tags.map{|item| item.name}.should include("This", "New", "Headline")
			@tags.each do |tag|
				tag.count.should == 1
			end
		end

		it "should increment tags if already exist" do
			Tag.create :name => "This", :count => 1
			Tag.create :name => "New", :count => 1
			headline = @user.headlines.create :name => "THIS is a new heaDLine"
			headline.tags.current.count.should == 3
			headline.tags.current.find_by_name("This").count.should == 2
			headline.tags.current.find_by_name("New").count.should == 2
			headline.tags.current.find_by_name("Headline").count.should == 1
		end

	end

	describe "Using mutliple users" do

		before :each do
			15.times do |i|
				user = Factory.build(:user)
				user.skip_confirmation!
				user.save
				user.headlines.build :name => "Previous Headline", :created_at => Headline.get_start_date + 1.hour - 2.day
				user.save
				user.headlines.build :name => "Previous Headline", :created_at => Headline.get_start_date + 1.hour - 3.day
				user.save
				user.headlines.build :name => "Headline"
				user.save 
			end
		end

		it "should get 10 last headlines randomly" do
			@headlines = Headline.get_ten_random_current_headlines
			@headlines.count.should == 10
			@headlines.each do |headline|
				headline.created_at.should >= Headline.get_start_date
			end
		end

	end
	
end
