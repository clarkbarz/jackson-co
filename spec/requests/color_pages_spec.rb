require 'spec_helper'

describe "ColorPages" do
	let!(:admin)  	{ FactoryGirl.create(:admin) }
	let!(:product) 	{ FactoryGirl.create(:shirt) }
	let!(:color_one) { product.colors.create(color_one: "blue", color_two: "green") }

	subject { page }

	describe "new" do
		before do
			sign_in_and_visit admin, product_path(product)
			click_link "Add Color"
		end

		it { should have_content("New Color for #{product.name}") }

		describe "with invalid information" do
			it "should not create a new color" do
				expect{ click_button "Create Color" }.not_to change(Color, :count)
			end

			describe "after submission" do
				before { click_button "Create Color" }

				it { should have_content("New Color for #{product.name}") }
				it { should have_selector("div.alert.alert-error") }
			end
		end

		describe "with valid information" do
			before do
				fill_in "color_color_one", with: "grey"
				fill_in "color_color_two", with: "black"
			end

			it "should create a new color" do
				expect{ click_button "Create Color" }.to change(Color, :count).by(1)
			end

			describe "after submission" do
				before { click_button "Create Color" }

				it { should have_content(product.name) }
				it { should have_selector("div.alert.alert-success", text: "Color created!") }
				it { should have_selector('option', text: "grey/black") }
			end
		end
	end
end