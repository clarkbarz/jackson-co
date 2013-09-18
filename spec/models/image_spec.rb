require 'spec_helper'

describe Image do
  let(:product) { FactoryGirl.create(:jacket) }
  before do
  	@color = Color.create(color_one: "blue", color_two: "black", product_id: product.id)
  	@image = Image.new(name: "jacket.jpg", color_id: @color.id)
  end

  subject { @image }

  it { should respond_to(:name) }
  it { should respond_to(:color_id) }

  describe "when color id isn't present" do
  	before { @image.color_id = nil }
  	it { should_not be_valid }
  end

  describe "when image name" do

  	describe "is not present" do
  		before { @image.name = nil }
  		it { should_not be_valid }
  	end

  	describe "is blank" do
  		before { @image.name = " " }
  		it { should_not be_valid }
  	end

  	describe "is too long" do
  		before { @image.name = "b" * 55 }
  		it { should_not be_valid }
  	end

  	describe "is the wrong format" do
  		invalid_names = ["jacket-jpg", "friendship", "shirt,png", "fleeceimg"]
  		invalid_names.each do |nombre|
  			before { @image.name = nombre }
  			it { should_not be_valid }
  		end
  	end

  	describe "is the correct format" do
  		valid_names = ["fleece.jpg", "shirt.png", "shirt_a.jpg"]
  		valid_names.each do |nombre|
  			before { @image.name = nombre }
  			it { should be_valid }
  		end
  	end
  end

  describe "file_path function" do
  	its(:file_path) { should eq "products/jacket/#{@image.color_id}_#{@image.name}" }
  end
end
