FactoryGirl.define do
	factory :user do
		name			"Jelly Doughnut"
		email   	"jelly@example.com"
		password 	"password"
		password_confirmation "password"
	end
end