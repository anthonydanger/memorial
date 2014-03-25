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

		User.all.each { |user| user.avatar = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample); user.save! }
	end
end