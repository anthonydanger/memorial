class Tribute < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates :user_id, :name, :dob, :dod, presence: true
end
