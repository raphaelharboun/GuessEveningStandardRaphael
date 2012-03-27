require 'spec_helper'

describe "Headlines" do

  before :each do
    devine = Factory.build(:devineUser)
    devine.skip_confirmation!
    devine.save
    15.times do |i|
      devine.headlines.create :name => "Headline devine #{i}", :created_at => Headline.get_start_date + 1.hour - i.day
    end
  end

  describe "Public Access" do

    before :each do
      u = Factory.build(:user)
      u.skip_confirmation!
      u.save
      u.headlines.create :name => "New standard User headline", :created_at => Headline.get_start_date - 2.day
    end
  	
  	it "prevent unidentified person to post headline" do
  		visit "/"

  		fill_in 'headline_name', :with => 'My new Headline'
  		click_button 'Print it'

  		current_path.should == new_user_session_path
  	end

    it "redirect unidentified user if try to access me/headlines" do
      visit "/me/headlines"
      current_path.should == user_session_path
    end

    it "redirect unidentified user trying to access me/current" do
      visit me_current_path
      current_path.should == user_session_path
    end

    it "allow public to access user/:id/headlines" do
      u = User.standard.first
      visit "/user/" + u.id.to_s + "/headlines"
      current_path.should == "/user/" + u.id.to_s + "/headlines"
    end

    it "redirect user when accessing devineUser headlines with user/:id/headlines" do
      u = DevineUser.first
      visit "/user/" + u.id.to_s + "/headlines"
      current_path.should == devine_headlines_path
    end

    it "allow public to access headline/:id" do
      u = User.standard.first
      visit headline_path(u.headlines.first)
      page.should have_content u.headlines.first.name
    end

    it "render 404 when wrong :id with user/:id/headline" do
      visit "/user/1525/headlines"
      page.status_code.should == 404
    end

    it "render 404 when wrong :headline_id with headlines/:headline_id" do
      visit "/headline/1243"
      page.status_code.should == 404
    end


  end

  describe "User Logged in" do
  	include Warden::Test::Helpers
  	Warden.test_mode!

  	before :each do
  		@user = Factory.build(:user)
  		@user.skip_confirmation!
  		@user.save!
  		login_as(@user, :scope => :user)
  	end

    it "should post a headline" do
      visit "/"
      fill_in 'headline_name', :with => 'headline 1'
      click_button 'Print it'
      current_path.should == me_headlines_path
      page.should have_content "Headline saved"
    end

  	it "doesn't save empty headline" do
  		visit "/"
  		click_button 'Print it'
  		current_path.should == root_path
  		page.should have_content "can't be blank"
  	end

    it "render the current_headline partial if current" do
      visit "/me/headlines"
      page.should_not have_content "Your next issue headline"
      @user.headlines.create :name => "My new Standard headline"
      visit "/me/headlines"
      page.should have_content "Your next issue headline"
    end

    it "redirect from me/current to me/headlines if no current" do
      visit "/me/current"
      current_path.should == me_headlines_path
    end


  	Warden.test_reset!
  end



end
