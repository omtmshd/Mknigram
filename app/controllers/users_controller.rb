class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index edit update destroy following followers]

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    User.find(params[:id]).update(user_params)
    redirect_to user_path(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user: @user)
  end

  def destroy; end

  def index
    if !current_user.nil?
      redirect_to user_path(current_user.id)
    else
      redirect_to sign_in_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :profile)
  end
end
