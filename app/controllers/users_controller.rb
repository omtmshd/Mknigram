class UsersController < ApplicationController

  def edit
    @user=User.find(params[:id])
  end

  def update
    User.find(params[:id]).update(user_params)
    redirect_to user_path(params[:id])
  end

  def show
    @user=User.find(params[:id])
  end

  def destroy
  end

  def index
    if current_user != nil
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
