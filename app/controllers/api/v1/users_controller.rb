class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_user!, only: %i[update]
  before_action :set_user, only: %i[update show following followers follow_data posts]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  # すべてのUserを9個ずつ返す
  def index
    render json: User.all.limit(9).offset(params[:data_id]).to_json(only: %i[id name profile profile_image])
  end

  def show
    render json: @user.to_json(
      only: %i[id name profile profile_image]
    )
  end

  def update
    if @user.update_attributes(user_params) && @user.id == current_api_user.id
      head :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # フォロー中のユーザーデータ取得
  def following
    render json: @user.following.to_json(
      only: %i[id name profile profile_image]
    )
  end

  # フォロワーユーザーデータ取得
  def followers
    render json: @user.followers.to_json(
      only: %i[id name profile profile_image]
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

  # ログインユーザーを返す
  def current
    render json: current_api_user.to_json(only: %i[id name profile profile_image])
  end

  # Userと紐付いたPostを15個ずつ返す
  def posts
    render json: @user.posts.limit(15).offset(params[:data_id]).to_json(
      only: %i[id title body post_image],
      include: [
        user: { only: %i[id name profile_image] }
      ]
    )
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :profile)
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
