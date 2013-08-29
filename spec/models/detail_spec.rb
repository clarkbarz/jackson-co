require 'spec_helper'

describe Detail do
	let(:product) { FactoryGirl.create(:jacket) }
  before do
  	@detail = Detail.new(content: "made of goretex", product_id: product.id)
  end

  subject { @detail }

  it { should respond_to(:content) }
  it { should respond_to(:product_id) }

  describe "when product id isn't present" do
  	before { @detail.product_id = nil }
  	it { should_not be_valid }
  end

  describe "when product content" do

  	describe "is not present" do
  		before { @detail.content = nil }
  		it { should_not be_valid }
  	end

  	describe "is blank" do
  		before { @detail.content = " " }
  		it { should_not be_valid }
  	end

  	describe "is too long" do
  		before { @detail.content = "b" * 165 }
  		it { should_not be_valid }
  	end
  end
end
