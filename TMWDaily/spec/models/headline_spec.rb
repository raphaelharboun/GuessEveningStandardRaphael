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
			@headlines = Headline.get_random_current_headlines 10
			@headlines.count.should == 10
			@headlines.each do |headline|
				headline.created_at.should >= Headline.get_start_date
			end
		end

	end

	describe "devineUser" do

		it "shouldn't increase tag count for devineUser" do
			devine = Factory.build(:devineUser)
			devine.skip_confirmation!
			devine.save
			Tag.count.should == 0
			devine.headlines.create :name => "Devine New Headline"
			Tag.count.should == 3
			Tag.all.each do |tag|
				tag.count.should == 0
			end
		end

	end

	describe "Scoring" do

		before :each do
			user = Factory.build(:user)
			user.skip_confirmation!
			user.save
			devineuser = Factory.build(:devineUser)
			devineuser.skip_confirmation!
			devineuser.save
			devineuser.headlines.create :name => "My new Headline"
		end

		it "should increase score by tag" do
			devine = DevineUser.first
			user = User.first
			user.headlines.create :name => "My new Headline"
			devine_headline = devine.headlines.first
			devine_headline.set_score_by_tags
			user.headlines.first.score.should == 11
		end

		it "should increase score by headline length" do
			devine = DevineUser.first
			devine_headline = devine.headlines.first
			user = User.standard.first	
			user.headlines.create :name => "My new Headline should say zero score"
			devine_headline.set_score_by_headline_length
			user.headlines.first.score.should == 0
		end

		it "should correctly score headline" do
			devine_headline = DevineUser.first.headlines.first
			user = User.standard.first
			user.headlines.create :name => "My new Headline"
			devine_headline.set_score
			user.headlines.first.score.should == 14
		end

	end
	
end
