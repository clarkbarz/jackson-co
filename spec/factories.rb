FactoryGirl.define do
	factory :customer do
		sequence(:email) { |n| "customer_#{n}@gmail.com" }
		password "fireitagain"
		password_confirmation "fireitagain"

		factory :admin do
			admin true
		end
	end
end