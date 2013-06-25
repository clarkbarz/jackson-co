require 'spec_helper'

describe Customer do

  before { @customer = Customer.new(email: "email@real.org", password: "moonboy", password_confirmation: "moonboy") }

  subject { @customer }

  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }

  it { should be_valid }
  it { should_not be_admin}

  describe "with admin attribute set to 'true'" do
    before do
      @customer.save!
      @customer.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when customer email is not present" do
  	before { @customer.email = " " }
  	it { should_not be_valid }
  end

  describe "when customer email is an invalid format" do
  	invalid_emails = %w["foo@exxon", "customer_foo.org", "foo@customer,com", "guy@friend_com.org" "guy.friend.com", "example@foo.", "guy@..exx", "friend@foo+baz.com" "neder@jimmy..fresh"]
  	invalid_emails.each do |invalid|
  		before { @customer.email = invalid }
  		it { should_not be_valid }
  	end
  end

  describe "when customer email is in valid format" do
  	valid_emails = %w[customer@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  	valid_emails.each do |valid|
  		before { @customer.email = valid }
  		it { should be_valid }
  	end
  end

  describe "when email address is already taken" do
  	before do
  		customer_with_same_email = @customer.dup
  		customer_with_same_email.email = @customer.email.upcase
  		customer_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
  	before do
  		@customer = Customer.new(email: "ben@dover.com", password: "flight",password_confirmation: "johnson")
  	end
  	it { should_not be_valid}
  end

  describe "when password confirmation is nil" do
  	before do
  		@customer = Customer.new(email: "kurt@fan4.com", password: "crab_dip", password_confirmation: nil)
  	end
  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  	before { @customer.save }
  	let(:found_customer) { Customer.find_by(email: @customer.email) }

  	describe "with valid password" do
  		it { should eq found_customer.authenticate(@customer.password) }
  	end

  	describe "with invalid password" do
  		let(:customer_for_invalid_password) { found_customer.authenticate("invalid") }

  		it { should_not eq customer_for_invalid_password }
  		specify { expect(customer_for_invalid_password).to be_false }
  	end
  end

  describe "with a password that's too short" do
  	before { @customer.password = @customer.password_confirmation = "a" * 5 }
  	it { should be_invalid }
  end

  describe "remember token" do
    before { @customer.save }
    its(:remember_token) { should_not be_blank }
  end
end
