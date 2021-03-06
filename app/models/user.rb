class User < ActiveRecord::Base
	has_many :tributes
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
																		uniqueness: { case_sensitive: false }														
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

  def following?(tribute)
    relationships.find_by(followed_id: tribute.id)
  end

  def follow!(tribute)
    relationships.create!(followed_id: tribute.id)
  end

  def unfollow!(tribute)
    relationships.find_by(followed_id: tribute.id).destroy
  end

private
	
	def create_remember_token
		self.remember_token = User.hash(User.new_remember_token)
	end 
end
