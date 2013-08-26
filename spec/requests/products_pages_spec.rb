require 'spec_helper'

describe "ProductsPages" do
	let(:jacket) { FactoryGirl.create(:jacket) }
	let(:fleece) { FactoryGirl.create(:fleece) }
	let(:shirt_a) { FactoryGirl.create(:shirt) }
	let(:shirt_b) { FactoryGirl.create(:shirt) }

	subject { page }

  describe "show" do
    before { visit product_path(jacket) }

    it { should have_content(jacket.name) }
    it { should have_selector('p', text: jacket.description) }
  end

  describe "index" do
  	before { visit products_path }

  	it { should have_content("Product Index") }

  	it "should list each product" do
  		Product.all.each do |product|
  			expect(page).to have_selector('a', text: product.name)
  		end
  	end
  end
end
