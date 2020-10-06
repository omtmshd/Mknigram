class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_user!, only: %i[update]
  before_action :set_user, only: %i[updates following followers follow_data posts list_folders]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  # すべてのUserを9個ずつ返す
  def index
    render json: User.all.select(:id, :name, :profile, :profile_image).limit(9).offset(params[:data_id])
  end

  def show
    render json: User.select(:id, :name, :profile, :profile_image).find(params[:id])
  end

  def update
    if @user.id == current_api_user.id && @user.update_attributes(user_params)
      head :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # フォロー中のユーザーデータ取得
  def following
    render json: @user.following.select(:id, :name, :profile, :profile_image)
  end

  # フォロワーユーザーデータ取得
  def followers
    render json: @user.followers.select(:id, :name, :profile, :profile_image)
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
    render json: User.select(:id, :name, :email, :profile, :profile_image).find(current_api_user.id)
  end

  # Userと紐付いたPostを15個ずつ返す
  def posts
    render json: @user.posts.select(:id, :title, :body, :post_image, :user_id).limit(15).offset(params[:data_id])
  end

  # ユーザーのリストを返す
  def list_folders
    render json: @user.list_folders.select(:id, :name)
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
