include ApplicationHelper

def sign_in(customer)
  visit signin_path
  fill_in "Email",    with: customer.email
  fill_in "Password", with: customer.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = customer.remember_token
end