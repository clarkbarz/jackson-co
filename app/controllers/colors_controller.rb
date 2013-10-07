class ColorsController < ApplicationController
	before_action :get_product

	def new
		@color = @product.colors.build
	end

	def create
		@color = @product.colors.create(color_params)
		if @color.save
			flash[:success] = "Color created!"
			redirect_to product_path(@product)
		else
			render 'new'
		end
	end

	# def destroy
	# 	@product.details.find(params[:id]).destroy
	# 	redirect_to product_path(@product)
	# end

	private

		def color_params
			params.require(:color).permit(:color_one, :color_two, :color_thr)
		end

		def get_product
			if params[:color]
				@product = Product.find(params[:color][:product_id])
			elsif params[:product_id]
				@product = Product.find(params[:product_id].to_i)
			end
		end
end