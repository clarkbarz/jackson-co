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

  describe "shirts" do
    before { visit products_shirts_path }

    it { should have_content "Shirts" }
    it { should have_link(shirt_a.name) }
  end

  describe "index" do
  	before { visit products_path }

  	it { should have_content("Product Index") }

  	it "should list each product" do
  		Product.all.each do |product|
  			expect(page).to have_selector('a', text: product.name)
  		end
  	end

    describe "with admin access" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit products_path
      end

      it "should have delete links" do
        expect(page).to have_selector('a', text: "Edit")
      end

      it "should have delete links" do
        expect(page).to have_selector('a', text: "Delete")
      end

      it "should be able to delete products" do
        expect{ first(:link, "Delete").click }.to change(Product, :count).by(-1)
      end
    end
  end

  describe "new" do
    before { visit new_product_path }

    it { should have_content("JACKSON") }

    describe "with admin access" do
      let(:admin) { FactoryGirl.create(:admin) }

      before do
        sign_in admin
        visit new_product_path
      end

      it { should have_content("New Product") }

      describe "with invalid information" do
        it "should not create a product" do
          expect{ click_button "Create Product" }.not_to change(Product, :count)
        end

        describe "after submission" do
          before { click_button "Create Product" }

          it { should have_content("New Product") }
          it { should have_content("error") }
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name", with: "Airproof Fleece"
          select "Fleece", from: "Category"
          fill_in "Description", with: "This is a fleece. It's warm. Please enjoy it."
          fill_in "Price", with: "135.99"
        end

        it "should create a new product" do
          expect{ click_button "Create Product" }.to change(Product, :count).by(1)
        end

        describe "after saving the product" do
          before { click_button "Create Product" }

          it { should have_selector("div.alert.alert-success", text: "Airproof Fleece created") }
          it { should have_content("Product Index") }
        end
      end
    end
  end
end
