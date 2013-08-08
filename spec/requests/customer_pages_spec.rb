require 'spec_helper'

describe "CustomerPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create Account" }

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

    	describe "after saving the Customer" do
        before { click_button submit }
        let(:customer) { Customer.find_by(email: "email@email.gov") }

        it { should have_link('Sign out') }
        it { should have_title('Jackson') }
    		it { should have_selector('div.alert.alert-success', text: 'Welcome!') }
    	end
    end
  end

  describe "edit" do
    let(:customer) { FactoryGirl.create(:customer) }
    before do
      sign_in customer
      visit edit_customer_path(customer)
    end

    describe "page" do
      it { should have_content("Update your account") }
      it { should have_title('Edit Account') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_email) { "new@email.com" }
      before do
        fill_in "Email", with: new_email
        fill_in "Password", with: customer.password
        fill_in "Confirmation", with: customer.password
        click_button "Save changes"
      end

      it { should have_title(new_email) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(customer.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: customer.password, password_confirmation: customer.password } }
      end
      before { patch customer_path(customer), params }
      specify { expect(customer.reload).not_to be_admin }
    end
  end
end
