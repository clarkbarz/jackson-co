require 'spec_helper'

describe Size do
  let(:product) { FactoryGirl.create(:jacket) }
  before do
  	@color = Color.new(color_one: "green", color_two: "grey", product_id: product.id)
  	@size = Size.new(letter: "M", product_id: product.id, color_id: @color.id)
  end

  subject { @size }

  it { should respond_to(:letter) }
  it { should respond_to(:product_id) }
  it { should respond_to(:color_id) }

  describe "when product id isn't present" do
  	before { @size.product_id = nil }
  	it { should_not be_valid }
  end

  describe "when color id isn't present" do
  	before { @size.color_id = nil }
  	it { should_not be_valid }
  end

  describe "when size letter" do

  	describe "is not present" do
  		before { @size.letter = nil }
  		it { should_not be_valid }
  	end

  	describe "is blank" do
  		before { @size.letter = " " }
  		it { should_not be_valid }
  	end

  	describe "is too long" do
  		before { @size.letter = "b" * 2 }
  		it { should_not be_valid }
  	end
  end
end
