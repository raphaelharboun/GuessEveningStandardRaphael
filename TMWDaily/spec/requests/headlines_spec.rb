require 'spec_helper'

describe "Headlines" do
  describe "Not Log in" do
  	
  	it "prevent unidentified person to post headline" do
  		visit "/"

  		fill_in 'headline_name', :with => 'My new Headline'
  		click_button 'Print it!'

  		current_path.should == new_user_session_path
  	end

  end

  describe "User Logged in" do
  	include Warden::Test::Helpers
  	Warden.test_mode!

  	before :each do
  		user = Factory(:user)
  		user.skip_confirmation!
  		user.save!
  		login_as(user, :scope => :user)
  	end

    it "should post a headline" do
      visit "/"

      fill_in 'headline_name', :with => 'headline 1'
      click_button 'Print it!'

      current_path.should == root_path
      page.should have_content "Headline saved"
    end

  	it "doesn't save empty headline" do
  		visit "/"

  		click_button 'Print it!'

  		current_path.should == root_path
  		page.should have_content "Headline can't be blank"
  	end

  	Warden.test_reset!
  end


end
