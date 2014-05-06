class TributesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :edit, :show]

  def new
    @tribute = current_user.tributes.build if signed_in?
  end
 
  def edit
  end

  def index
    @tributes = Tribute.all
  end

  def show
   @tribute = Tribute.find(params[:id])
   @user = User.find(@tribute.user_id)
  end

  def create
  	@tribute = current_user.tributes.build(tribute_params)
  	if @tribute.save
  		flash[:success] = "Tribute Created."
  		redirect_to @tribute
  	else
  		render 'new'
    end
  end

  def destroy
    #@tribute.destroy
    #redirect_to tributes_url
  end

  def following
    @title = "Following"
    @tribute = Tribute.find(params[:id])
    @users = @tribute.followed_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @tribute = Tribute.find(params[:id])
    @users = @tribute.followers
    render 'show_follow'
  end


private

  	def tribute_params
  		params.fetch(:tribute, {}).permit(:name, :obituary, :dob, :dod, :image)
  	end
end