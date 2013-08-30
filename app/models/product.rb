class Product < ActiveRecord::Base
	has_many :details, dependent: :destroy
	has_many :colors, dependent: :destroy
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :category, presence: true
	validates :description, presence: true, length: { maximum: 300 }
	validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000 }
	self.per_page = 10
end
