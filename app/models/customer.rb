class Customer < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation
	before_save { create_remember_token }
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
  									uniqueness: { case_sensitive: false },
  									format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
