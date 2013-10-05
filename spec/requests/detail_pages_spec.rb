require 'spec_helper'

describe "DetailPages" do
	let(:product) { FactoryGirl.create(:jacket) }
	let(:admin) { FactoryGirl.create(:admin) }

	subject { page }

	describe "new" do
		before do
			sign_in_and_visit admin, product_path(product)
			click_link "Add Detail"
		end

		it { should have_content("New Detail for #{product.name}") }

		describe "with invalid information" do
			it "should not save" do
				expect { click_button "Create Detail" }.not_to change(Detail, :count)
			end

			describe "after submission" do
				before { click_button "Create Detail" }
				it { should have_content("New Detail for #{product.name}") }
				it { should have_selector("div.alert.alert-error") }
			end
		end

		describe "with valid information" do
			before do
				fill_in "detail_content", with: "This jacket is the warmest!"
			end

			it "should save" do
				expect { click_button "Create Detail" }.to change(Detail, :count).by(1)
			end

			describe "after submission" do
				before { click_button "Create Detail" }

				it { should have_content("#{product.name}") }
				it { should have_content("This jacket is the warmest!") }
				it { should have_selector("div.alert.alert-success") }
			end
		end
	end
end
