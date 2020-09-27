class Api::V1::LikesController < ApplicationController
  before_action :authenticate_api_user!, only: %i[create destroy]

  def index
    render json: Like.filter_by_post(params[:post_id]).select(:id, :user_id, :post_id)
  end

  def create
    current_api_user.likes.create!(likes_params)
    head :created
  end

  def destroy
    current_api_user.likes.find(params[:id]).destroy!
    head :ok
  end

  # ユーザーがいいねしている投稿を返す(15個ずつ)
  def posts
    @user = User.find(params[:id])
    @posts = @user.liked_posts
    render json: @posts.limit(15).offset(params[:data_id]).to_json(
      only: %i[id title body post_image user_id]
    )
  end

  def users; end

  private

  def likes_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
