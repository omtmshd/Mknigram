class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_user!, only: %i[update]
  before_action :set_user, only: %i[update show following follow_data]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    users = User.all.to_json(only: %i[id name profile profile_image])
    render json: users
  end

  def show
    render json: @user.to_json(
      only: %i[id name profile profile_image],
      include: [
        posts: {
          only: %i[id title body post_image],
          include: [
            user: { only: %i[id profile_image] },
            categories: { only: %i[id name] }
          ]
        }
      ]
    )
  end

  def update
    if @user.update_attributes(user_params) && @user.id == current_api_user.id
      head :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # フォロー、フォロワーデータ取得
  def following
    render json: @user.to_json(
      only: %i[id name profile profile_image current_api_user],
      include: [
        following: { only: %i[id name profile profile_image] },
        followers: { only: %i[id name profile profile_image] }
      ]
    )
  end

  # フォロー、フォロワーデータ取得(idのみ)
  def follow_data
    render json: @user.to_json(
      only: [],
      include: [
        following: { only: [:id] },
        followers: { only: [:id] }
      ]
    )
  end

  def current
    render json: current_api_user.to_json(only: %i[id name profile profile_image])
  end

  private

  def user_params
    params.fetch(:user).permit(:profile_image, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
