class Image < ActiveRecord::Base
	belongs_to :color
	VALID_NAME_REGEX = /\w{2,50}/
	VALID_FORMAT_REGEX = /\.(jpg|png)/
	validates :color_id, presence: true
	validates :name, presence: true, format: { with: VALID_NAME_REGEX }, length: { maximum: 50 }
	validates :file_format, presence: true, format: { with: VALID_FORMAT_REGEX }

	def file_path
		return "products/#{color.product.category}/#{color.id}/#{name}#{file_format}"
	end
end
