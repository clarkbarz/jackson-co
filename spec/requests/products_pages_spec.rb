require 'spec_helper'

describe "ProductsPages" do
	let(:jacket) { FactoryGirl.create(:jacket) }
	let(:fleece) { FactoryGirl.create(:fleece) }
	let!(:shirt_a) { FactoryGirl.create(:shirt) }
	let!(:shirt_b) { FactoryGirl.create(:shirt) }

	subject { page }

  describe "show" do
    describe "pages" do
      Product.all.each do |prod|
        before { visit product_path(prod) }
        it { should have_content(prod.name) }
        it { should have_selector('p', text: prod.description) }
        prod.details.all.each do |deet|
          it { should have_selector('li', text: deet.content) }
        end
      end
    end
  end

  # describe "shirts" do
  #   before { page.find('a', text: "Shirts").click }

  #   it { should have_content "Shirts" }
  #   it { should have_link(shirt_a.name) }
  # end

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
