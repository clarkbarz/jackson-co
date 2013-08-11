# spec/requests/admin_spec.rb

require "spec_helper"

describe "site administration" do
	let!(:customer) { FactoryGirl.create(:customer) }
	let!(:admin) { FactoryGirl.create(:admin) }

	describe "admin link" do

		it "when logged in" do
			sign_in admin
			page.should have_link('Admin')
		end

		it "when non-admin user" do
			sign_in customer
			page.should_not have_link('Admin')
		end
	end

	describe "dashboard access" do

		it "is accessed by admin link" do
			sign_in admin
			click_link 'Admin'

			current_path.should eq admin_path
			page.should have_content 'Site Administration'
			page.should have_content 'Manage Users'
			page.should have_content 'Manage Products'
		end

		it "is denied when not admin" do
			expect{ visit admin_path }.to redirect_to(root_path)
		end
	end
end