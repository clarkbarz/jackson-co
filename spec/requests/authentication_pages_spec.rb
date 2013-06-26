require 'spec_helper'

describe "AuthenticationPages" do
  describe "signin page" do
  	before { visit signin_path }

  	it { should have_content 'Sign in' }
  	it { should have_title 'Sign in' }
  end

  describe "signin" do
  	before { visit signin_path }

  	describe "with invalid information" do
  		before { click_button "Sign in" }

  		it { should have_title 'Sign in' }
  		it { should have_selector 'div.alert.alert-error', text: 'Invalid email/password combination' }
  		it { should_not have_link 'Settings' }
  		it { should_not have_link 'Sign out' }
  	end
  end
end
