class CustomersController < ApplicationController
	before_action :signed_in_customer, only: [:edit, :update, :destroy]
	before_action :correct_customer, only: [:edit, :update]
	before_action :admin_customer, only: [:index, :destroy]

	def index
		@customers = Customer.paginate(page: params[:page])
	end

	def show
		@customer = Customer.find(params[:id])
	end

	def new
		@customer = Customer.new
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			sign_in @customer
			flash[:success] = "Welcome!"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @customer.authenticate(params[:customer][:old_password])
			if @customer.email != params[:customer][:email]
				@customer.update_attribute :email, params[:customer][:email]
				sign_in_redirect_to @customer
			elsif @customer.update_attributes(customer_params)
				sign_in_redirect_to @customer
			else
				render 'edit'
			end
		else
			flash.now[:error] = "Password is incorrect"
			render 'edit'
		end
	end

	def destroy
		Customer.find(params[:id]).destroy
		flash[:success] = "Customer destroyed"
		redirect_to customers_url
	end

	private

		def customer_params
			params.require(:customer).permit(:email, :password, :password_confirmation)
		end

		def sign_in_redirect_to(customer)
			flash[:success] = "Profile updated"
			sign_in customer
			redirect_to customer
		end

		def correct_customer
			@customer = Customer.find(params[:id])
			redirect_to(root_path) unless current_user?(@customer)
		end

		def admin_customer
			redirect_to(root_path) unless current_customer.admin?
		end
end
