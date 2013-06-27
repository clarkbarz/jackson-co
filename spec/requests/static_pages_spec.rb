require 'spec_helper'

describe "StaticPages" do
	let(:base_title) { "Jackson" }
	subject { page }

  describe "home page" do
  	before { visit root_path }

  	it { should have_content("#{base_title}") }
  	it { should have_title(full_title('Home')) }
  end

  describe "about page" do
  	before { visit about_path }

  	it { should have_content("About #{base_title}") }
  	it { should have_title(full_title('About')) }
  end

  describe "help page" do
  	before { visit help_path }

  	it { should have_content("Help") }
  	it { should have_title(full_title("Help")) }
  end

  it "should have the right link destinations" do
  	before { visit root_path }
  	click_link "About"
  	expect(page).to have_content("About #{base_title}")
  	click_link "Sign in"
  	expect(page).to have_content("Sign in")
  	click_link "Jackson"
  	expect(page).to have_content("#{base_title}")
  end
end
