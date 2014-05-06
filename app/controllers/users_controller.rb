class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def new
  	@user = User.new
  end

  def edit
  end

  def show
  	@user = User.find(params[:id])
    @tributes = @user.tributes
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def create
  	@user = User.create( user_params )
  	if @user.save
      sign_in @user
  		flash[:success] = "Thank you for joining Memorials"
  		redirect_to @user
    else
  		render 'new'
  	end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted."
    redirect_to users_path
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

private 

  def user_params
	 params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please Sign In."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
