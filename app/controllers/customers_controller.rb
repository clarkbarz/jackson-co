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
			flash[:success] = "Welcome"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @customer.update_attributes(customer_params)
			flash[:success] = "Update successful"
			sign_in @customer
			redirect_to @customer
		else
			render 'new'
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

		def correct_customer
			@customer = Customer.find(params[:id])
			redirect_to(root_path) unless current_user?(@customer)
		end

		def admin_customer
			redirect_to(root_path) unless current_customer.admin?
		end
end
