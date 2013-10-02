class ProductsController < ApplicationController
	before_action :admin_customer, only: [:new, :create, :edit, :update, :destroy]

	def index
		@products = Product.paginate(page: params[:page]).order('id')
	end

	def show
		@product = Product.find(params[:id])
	end

	def shirts
		@products = Product.where("category = 'shirt'").paginate(page: params[:page])
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		alt_name = @product.name.downcase.split
		@product.alt_name = alt_name.join("_")
		if @product.save
			flash[:success] = "#{@product.name} created"
			redirect_to products_path
		else
			render 'new'
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(product_params)
			redirect_to edit_product_path(@product)
		else
			render 'edit'
		end
	end

	def destroy
		Product.find(params[:id]).destroy
		flash[:success] = "Product destroyed"
		redirect_to products_path
	end

	private

		def product_params
			params.require(:product).permit(:name, :category, :description, :price)
		end

		def admin_customer
			unless current_customer && current_customer.admin?
				flash[:notice] = "Restricted page"
				redirect_to(root_path)
			end
		end
end
