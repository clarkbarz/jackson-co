require 'spec_helper'

describe "ProductsPages" do
	let!(:jacket) { FactoryGirl.create(:jacket) }
	let!(:fleece) { FactoryGirl.create(:fleece) }
	let!(:shirt_a) { FactoryGirl.create(:shirt) }
	let!(:shirt_b) { FactoryGirl.create(:shirt) }
  let!(:admin) { FactoryGirl.create(:admin) }

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
      before { sign_in_and_visit admin, products_path }

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
      before { sign_in_and_visit admin, new_product_path }

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

  describe "edit" do
    before { visit edit_product_path(fleece) }

    it { should have_content("JACKSON") }

    describe "with admin access" do
      let(:new_name) { "Jackson Co Shirt" }
      let(:new_category) { "Shirt" }
      let(:new_description) { "This product is not a fleece anymore. It's more of a shirt, and that's what we made it."}
      let(:new_price) { "45.99" }
      before { sign_in_and_visit admin, edit_product_path(fleece) }

      it { should have_content("Edit Product") }
      describe "with invalid information" do
        before do
          click_button "Edit Name"
          fill_in "product_name", with: " "
          click_button "save-product-name"
        end

        it { should have_selector("div.alert.alert-error") }
        it { should have_content("Edit Product") }
      end

      describe "should allow name to change" do
        before do
          click_button "Edit Name"
          fill_in "product_name", with: new_name
          click_button "save-product-name"
        end

        it { should have_content(new_name) }
      end

      describe "should allow category to change" do
        before do
          click_button "Edit Category"
          select new_category, from: "product_category"
          click_button "save-product-category"
        end

        it { should have_content(new_category) }
      end

      describe "should allow description to change" do
        before do
          click_button "Edit Description"
          fill_in "product_description", with: new_description
          click_button "save-product-description"
        end

        it { should have_content(new_description) }
      end

      describe "should allow price to change" do
        before do
          click_button "Edit Price"
          fill_in "product_price", with: new_price
          click_button "save-product-price"
        end

        it { should have_content(new_price) }
      end
    end
  end
end
