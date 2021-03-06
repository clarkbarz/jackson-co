require 'spec_helper'

describe Product do
  before do
    @product = FactoryGirl.build(:jacket, name: "High Altitude Jacket", description: "This jacket is well-made with Goretex and whatever other stuff. Triple seams and wind-force protection. This description doesn't make sense, but that's alright")
  end

  subject { @product }

  its(:name) { should be_present }
  its(:category) { should be_present }
  its(:description) { should be_present }
  its(:price) { should be_present }
  its(:alt_name) { should be_present }

  it { should respond_to(:name) }
  it { should respond_to(:category) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }
  it { should respond_to(:alt_name) }
  it { should respond_to(:images) }
  it { should respond_to(:details) }
  it { should respond_to(:colors) }
  it { should respond_to(:sizes) }

  describe "when name is not present" do
    before { @product.name = nil }
    it { should_not be_valid }
  end

  describe "when name is blank" do
    before { @product.name = " " }
    it { should_not be_valid }
  end

  describe "when alt name is not present" do
    before { @product.name = nil }
    it { should_not be_valid }
  end

  describe "when alt name is blank" do
    before { @product.name = " " }
    it { should_not be_valid }
  end

  describe "when name is the same as another product" do
    before do
      new_product = @product.dup
      new_product.name = @product.name.upcase
      new_product.save
    end

    it { should_not be_valid }
  end

  describe "is invalid without a category" do
    before { @product.category = nil }
    it { should_not be_valid }
  end

  describe "is invalid without a description" do
    before { @product.description = nil }
    it { should_not be_valid }
  end

  describe "is invalid with too long of a description" do
    before { @product.description = "a" * 301 }
    it { should_not be_valid }
  end

  describe "is invalid without a price" do
    before { @product.price = nil }
    it { should_not be_valid }
  end

  describe "is invalid with a negative price" do
    before { @product.price = -87.90 }
    it { should_not be_valid }
  end
end
