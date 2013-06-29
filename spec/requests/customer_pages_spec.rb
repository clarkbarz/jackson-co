require 'spec_helper'

describe "CustomerPages" do
  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create Account" }
    subject { page }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    describe "with invalid information" do
    	it "should not create a user" do
    		expect { click_button submit }.not_to change(Customer, :count)
    	end

    	describe "after submission" do
    		before { click_button submit }

    		it { should have_title(full_title('Sign up')) }
    		it { should have_content('error') }
    	end
    end

    describe "with valid information" do
    	before do
    		fill_in "Email", with: "email@email.gov"
    		fill_in "Password", with: "largeEskimos"
    		fill_in "Confirmation", with: "largeEskimos"
    	end

    	it "should create a new Customer" do
    		expect { click_button submit }.to change(Customer, :count).by(1)
    	end

    	describe "after saving the user" do
    		before { click_button submit }
    		let(:customer) { Customer.find_by(email: "email@email.gov") }

    		it { should have_content(customer.email) }
    		it { should have_selector('div.alert.alert-success') }
    	end
    end
  end
end
