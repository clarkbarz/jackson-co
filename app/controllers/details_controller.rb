class DetailsController < ApplicationController
	before_action :get_product

	def new
		@detail = @product.details.build
	end

	def create
		@detail = @product.details.create(detail_params)
		if @detail.save
			flash[:success] = "Detail created"
			redirect_to product_path(@product)
		else
			flash[:error] = "Invalid"
			render 'new'
		end
	end

	def destroy

	end

	private

		def detail_params
			params.require(:detail).permit(:content)
		end

		def get_product
			if params[:detail]
				@product = Product.find(params[:detail][:product_id])
			else
				@product = Product.find(params[:product_id].to_i)
			end
		end
end