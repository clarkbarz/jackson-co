require 'spec_helper'

describe "ProductsPages" do
	let(:jacket) { FactoryGirl.create(:jacket) }
	let(:fleece) { FactoryGirl.create(:fleece) }
	let(:shirt_a) { FactoryGirl.create(:shirt) }
	let(:shirt_b) { FactoryGirl.create(:shirt) }

	subject { page }

  describe "index" do
    let(:custy) { FactoryGirl.create(:customer) }

    describe "should have restricted access" do
      before { visit products_path }
      it { should have_content("Sign in") }
    end

  	before do
      sign_in custy
      visit products_path
    end

  	it { should have_content("Product Index") }

  	it "should list each product" do
  		Product.all.each do |product|
  			expect(page).to have_selector('a', text: product.name)
  		end
  	end
  end
end
