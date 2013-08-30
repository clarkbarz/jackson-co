require 'spec_helper'

describe Color do
  let(:product) { FactoryGirl.create(:jacket) }
  before do
  	@color = Color.new(color_one: "green", color_two: "grey", product_id: product.id)
  end

  subject { @color }

  it { should respond_to(:color_one) }
  it { should respond_to(:color_two) }
  it { should respond_to(:color_thr) }
  it { should respond_to(:product_id) }

  describe "when product id isn't present" do
  	before { @color.product_id = nil }
  	it { should_not be_valid }
  end

  describe "when color one" do

  	describe "is not present" do
  		before { @color.color_one = nil }
  		it { should_not be_valid }
  	end

  	describe "is blank" do
  		before { @color.color_one = " " }
  		it { should_not be_valid }
  	end

  end

  describe "when color two" do
  	describe "is not present" do
  		before { @color.color_two = nil }
  		it { should_not be_valid }
  	end

  	describe "is blank" do
  		before { @color.color_two = " " }
  		it { should_not be_valid }
  	end
  end

  describe "scheme function" do
  	describe "with two colors" do
  		its(:scheme) { should eq "green/grey"}
  	end

  	describe "with three colors" do
  		before { @color.color_thr = "brown" }
  		its(:scheme) { should eq "green/grey/brown" }
  	end
  end
end
