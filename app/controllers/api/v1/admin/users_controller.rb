class Api::V1::Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: %i[show destroy]

  def index
    render json: User.all.to_json(only: %i[id name email profile profile_image])
  end

  def show
    render json: @user
  end

  def destroy
    head :no_content if @user.destroy!
  end

  private

  def if_not_admin
    redirect_to root_path unless current_api_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
