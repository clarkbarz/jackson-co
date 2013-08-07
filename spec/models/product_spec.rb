require 'spec_helper'

describe Product do
  before { @product = Product.new(name: "High Altitude Jacket", category: "jacket", description: "This jacket is well-made with Goretex and whatever other stuff. Triple seams and wind-force protection. This description doesn't make sense, but that's alright", price: 259.99) }

  subject { @product }

  its(:name) { should be_present }
  its(:category) { should be_present }
  its(:description) { should be_present }
  its(:price) { should be_present }

  it { should respond_to(:name) }
  it { should respond_to(:category) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }

  it "is invalid without a name" do
    Product.create( name: nil, category: "jacket", description: "This is a jacket.", price: 199.99 ).should_not be_valid
  end

  it "is invalid without a category" do
    Product.create( name: "Jacket 1", category: nil, description: "This is a jacket.", price: 199.99 ).should_not be_valid
  end

  it "is invalid without a description" do
    Product.create( name: "Jacket 1", category: "jacket", description: nil, price: 199.99 ).should_not be_valid
  end

  it "is invalid without a price" do
    Product.create( name: "Jacket 1", category: "jacket", description: "This is a jacket.", price: nil ).should_not be_valid
  end

  it "is invalid with a negative price" do
    Product.create(  name: "Jacket 1", category: "jacket", description: "This is a jacket.", price: -35.99).should_not be_valid
  end
end
