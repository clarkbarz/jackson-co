class Image < ActiveRecord::Base
	belongs_to :color
	VALID_NAME_REGEX = /\w{2,25}\.(jpg|png)/
	validates :product_id, presence: true
	validates :color_id, presence: true
	validates :name, presence: true, format: { with: VALID_NAME_REGEX }

	def file_path
		return "products/#{product.category}/#{color_id}_#{name}"
	end
end
