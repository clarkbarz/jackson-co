class Size < ActiveRecord::Base
	belongs_to :product
	validates :letter, presence: true, length: { maximum: 1 }
	validates :product_id, presence: true
	validates :color_id, presence: true
end
