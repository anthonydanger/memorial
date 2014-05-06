class Tribute < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
end
