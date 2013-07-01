class SessionsController < ApplicationController

	def new
	end

	def create
		customer = Customer.find_by(email: params[:session][:email].downcase)
		if customer && customer.authenticate(params[:session][:password])
			sign_in customer
			redirect_back_or customer
		else
			flash.now[:error] = 'Invalid email or password'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
