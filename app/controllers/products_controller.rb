class ProductsController < ApplicationController
	before_action :signed_in_customer, only: [:index]

	def index
		@products = Product.paginate(page: params[:page])
	end

end
