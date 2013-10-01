require 'spec_helper'

describe Image do
  let(:product) { FactoryGirl.create(:jacket) }
  before do
  	@color = Color.create(color_one: "blue", color_two: "black", product_id: product.id)
  	@image = Image.new(name: "jacket", file_format: ".jpg", color_id: @color.id)
  end

  subject { @image }

  it { should respond_to(:name) }
  it { should respond_to(:file_format) }
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

  	describe "is the correct format" do
  		valid_names = ["fleece_jpg", "shirt_png", "shirt_a_9"]
  		valid_names.each do |nombre|
  			before { @image.name = nombre }
  			it { should be_valid }
  		end
  	end
  end

  describe "when image file format" do
    describe "is not present" do
      before { @image.file_format = nil }
      it { should_not be_valid }
    end

    describe "is blank" do
      before { @image.file_format = " " }
      it { should_not be_valid }
    end

    describe "is the wrong value" do
      before { @image.file_format = ".gif" }
      it { should_not be_valid }
    end
  end

  describe "file_path function" do
  	its(:file_path) { should eq "products/jacket/#{@image.color_id}/#{@image.name}#{@image.file_format}" }
  end
end
