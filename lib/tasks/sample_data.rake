namespace :db do
	desc "Fill database with sample products and user admin"
	task populate: :environment do
		admin = Customer.create!( email: "scottclark591@gmail.com",
															password: "foobar",
															password_confirmation: "foobar",
															admin: true )
		jacket = Product.create!( name: "Jacket",
															category: "jacket",
															description: "This is a good jacket, named after Marcus A, who wore it this one time.",
															price: 149.99 )
		fleece = Product.create!( name: "Fleece",
															category: "fleece",
															description: "This fleece will keep you warm, but only if you make the ultimate sacrifice: $79.99.",
															price: 79.99 )
		shirtA = Product.create!( name: "Shirt A",
															category: "shirt",
															description: "This shirt is the same as shirt B, except that it comes earlier in the alphabet and is thus, better."
															price: 29.99 )
		shirtB = Product.create!( name: "Shirt B",
															category: "shirt",
															description: "This shirt is the same as shirt A, except it's a little worse and costs a little bit more."
															price: 34.99 )
	end
end