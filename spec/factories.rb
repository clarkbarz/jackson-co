FactoryGirl.define do
	factory :customer do
		sequence(:email) { |n| "customer_#{n}@gmail.com" }
		password "fireitagain"
		password_confirmation "fireitagain"

		factory :admin do
			admin true
		end
	end

	factory :product do

		factory :jacket do
			sequence(:name) { |n| "Jacket #{n}" }
			sequence(:alt_name) { |n| "jacket_#{n}" }
			category "jacket"
			description "This is a jacket description"
			price 256.99
		end

		factory :fleece do
			sequence(:name) { |n| "Fleece #{n}" }
			sequence(:alt_name) { |n| "fleece_#{n}" }
			category "fleece"
			description "This is a fleece description"
			price 108.99
		end

		factory :shirt do
			sequence(:name) { |n| "Shirt #{n}" }
			sequence(:alt_name) { |n| "shirt_#{n}" }
			category "shirt"
			description "This is a shirt description"
			price 29.99
		end
	end
end