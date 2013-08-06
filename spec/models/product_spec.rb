require 'spec_helper'

describe Product do
  @product = Product.new(name: "High Altitude Jacket", category: "jacket", description: "This jacket is well-made with Goretex and whatever other stuff. Triple seams and wind-force protection. This description doesn't make sense, but that's alright", price: 259.99)

  subject { @product }

  its(:name) { should be_present }
  its(:category) { should be_present }
  its(:description) { should be_present }
  its(:price) { should be_present }

  it { should respond_to(:name) }
  it { should respond_to(:category) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }
end
