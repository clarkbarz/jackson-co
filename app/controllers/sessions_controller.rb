class SessionsController < ApplicationController

	def new
	end

	def create
		customer = Customer.find_by(email: params[:session][:email].downcase)
		if customer && customer.authenticate(params[:session][:password])
			sign_in customer
			flash[:success] = "Welcome!"
			redirect_back_or root_path
		else
			flash[:error] = "Invalid email/password combination"
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
