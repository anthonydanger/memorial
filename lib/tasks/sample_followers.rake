namespace :db do 
	desc "Give Tribute more followers"
	task follow: :environment do
		make_followers
	end
end

def make_followers
	users = User.all
	tribute = Tribute.find(7)
	followers = users[5..40]
	followers.each {|follower| follower.follow!(tribute)}
end
