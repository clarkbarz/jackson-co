class ProductsController < ApplicationController

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
		redirect_to products_path if @product.save
	end

	private

		def product_params
			params.require(:product).permit(:name, :category, :description, :price)
		end

end
