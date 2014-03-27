namespace :db do
	desc "Fill database with sample users"
	task populate: :environment do
		User.create!(name: "Example User",
									email: "example@example.com",
									password: "password",
									password_confirmation: "password")

		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@example.com"
			password = "password"
			User.create!(name: name,
										email: email,
										password: password,
										password_confirmation: password)
		end
			users = User.all(limit: 6)
			2.times do |n|
				obituary = Faker::Lorem.paragraph
				name = Faker::Name.name
				users.each { |user| user.tributes.create!(obituary: obituary,
																									name: name)}
		end
	end
end