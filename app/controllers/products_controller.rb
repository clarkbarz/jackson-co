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

end
