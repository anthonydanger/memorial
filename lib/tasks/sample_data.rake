namespace :db do
	desc "Fill database with sample users"
	task populate: :environment do
		make_users
		make_tributes
		make_relationships
	end
end

	def make_users
		admin = User.create!(name: "Example User",
												email: "example@example.com",
												password: "password",
												password_confirmation: "password",
												admin: true)

		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@example.com"
			password = "password"
			User.create!(name: name,
										email: email,
										password: password,
										password_confirmation: password)
		end
	end

	def make_tributes
			users = User.all(limit: 6)
			2.times do
				obituary = Faker::Lorem.paragraph(6)
				name = Faker::Name.name
				dob = "1981/01/01"
				dod = "2020/01/01"
				users.each { |user| user.tributes.create!(name: name,
																									obituary: obituary,
																									dob: dob,
																									dod: dod)}
		end
	end

	def make_relationships
		users = User.all
		user = users.first
		followed_users = users[2..50]
		followers 		 = users[3..40]
		followed_users.each { |followed| user.follow!(followed) }
		followers.each 			{ |follower| follower.follow!(user)}
end