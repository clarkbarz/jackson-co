require 'spec_helper'

describe "AuthenticationPages" do
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
      let(:customer) { FactoryGirl.create(:customer) }
      before do
        fill_in "Email", with: customer.email
        fill_in "Password", with: customer.password
        click_button "Sign in"
      end

      it { should have_content('JACKSON') }
      it { should have_link('Account',     href: customer_path(customer)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end
