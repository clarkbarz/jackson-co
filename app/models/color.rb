class Color < ActiveRecord::Base
	belongs_to :product
	has_many :images
	has_many :sizes
	validates :product_id, presence: true
	validates :color_one, presence: true, length: { maximum: 8 }
	validates :color_two, presence: true, length: { maximum: 8 }
	validates :color_thr, length: { maximum: 8 }

	def scheme
		if color_thr.blank?
			"#{color_one}/#{color_two}"
		else
			"#{color_one}/#{color_two}/#{color_thr}"
		end
	end
end
