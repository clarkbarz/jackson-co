require 'spec_helper'

describe "AuthenticationPages" do
  let(:customer) { FactoryGirl.create(:customer) }
  subject { page }

  describe "signin page" do
  	before { visit signin_path }

  	it { should have_content('Sign in') }
  	it { should have_title(full_title('Sign in')) }
  end

  describe "signin" do
  	before { visit signin_path }

  	describe "with invalid information" do
  		before { click_button "Sign in" }

  		it { should have_title(full_title('Sign in')) }
  		it { should have_selector('div.alert.alert-error', text: 'Invalid email/password combination') }
  		it { should_not have_link('Settings') }
  		it { should_not have_link('Sign out') }
  	end

    describe "with valid information" do
      before do
        fill_in "Email", with: customer.email
        fill_in "Password", with: customer.password
        click_button "Sign in"
      end

      it { should have_content(customer.email) }
      it { should have_selector('div.alert.alert-success', text: 'Welcome!') }
      it { should have_link('Account') }
      it { should have_link('Sign out') }
    end
  end
end
