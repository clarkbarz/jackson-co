require 'spec_helper'

describe "ProductsPages" do
	let!(:jacket) { FactoryGirl.create(:jacket) }
	let!(:fleece) { FactoryGirl.create(:fleece) }
	let!(:shirt_one) { FactoryGirl.create(:shirt) }
	let!(:shirt_two) { FactoryGirl.create(:shirt) }

	subject { page }

  describe "index" do
  	before { visit products_path }

  	it { should have_content("Product Index") }

  	it "should list each product" do
  		Product.all.each do |product|
  			expect(page).to have_selector('li', text: product.name)
  		end
  	end
  end
end
