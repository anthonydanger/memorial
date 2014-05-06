class RelationshipsController < ApplicationController
	before_action :signed_in_user

	def create
		@tribute = Tribute.find(params[:relationship][:followed_id])
		current_user.follow!(@tribute)
		respond_to do |format| 
			format.html { redirect_to @tribute }
			format.js
		end
	end

	def destroy
		@tribute = Relationship.find(params[:id]).followed
		current_user.unfollow!(@tribute)
		respond_to do |format|
			format.html { redirect_to @tribute }
			format.js
		end
	end
end