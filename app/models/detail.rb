 class Detail < ActiveRecord::Base
	belongs_to :product
	validates :product_id, presence: true
	validates :content, presence: true, length: { maximum: 160 }
end
