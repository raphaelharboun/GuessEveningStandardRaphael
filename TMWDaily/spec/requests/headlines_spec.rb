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

    it "allow user to access user/:id/headlines" do
      u = User.first
      visit "/user/" + u.id.to_s + "/headlines"
      page.should have_content "Previous Headlines"
    end

    it "allow user to access to user/:id/headline/:id" do
      u = User.first
      visit  "/user/" + u.id.to_s + "/headline/" + u.headlines.first.id.to_s
      page.should have_content "public headline"
    end

    it "redirect unidentified user trying to access me/headline/:id" do
      visit "/me/headline/" + User.first.headlines.first.id.to_s
      current_path.should == user_session_path
    end

  end

  describe "User Logged in" do
  	include Warden::Test::Helpers
  	Warden.test_mode!

  	before :each do
  		user = Factory.build(:user)
  		user.skip_confirmation!
  		user.save!
  		login_as(user, :scope => :user)
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

    it "allow user to access me/headline/:id" do
      visit "/me/headline/12"
      page.should have_content "private headline"
    end

    it "redirect user to public access when access to user/:id/headline/:id" do
      u = User.first
      visit "/user/" + u.id.to_s + "/headline/" + u.headlines.first.id.to_s
      page.should have_content "public headline"
    end

  	Warden.test_reset!
  end



end
