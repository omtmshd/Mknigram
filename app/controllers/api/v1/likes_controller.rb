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

  # ユーザーがいいねしている投稿を返す
  def posts
    @user = User.find(params[:id])
    @posts = @user.liked_posts
    render json: @posts.limit(9).offset(params[:data_id]).to_json(
      only: %i[id title body post_image],
      include: [
        user: { only: %i[id name profile_image] },
        categories: { only: %i[id name] }
      ]
    )
  end

  def users; end

  private

  def likes_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
