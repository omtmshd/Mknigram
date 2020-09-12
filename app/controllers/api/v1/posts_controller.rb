class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_user!, only: %i[create update destroy]
  before_action :set_post, only: %i[show update destroy]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  # 10個ずつデータを取得
  def index
    render json: Post.all.limit(10).offset(params[:data_id]).to_json(
      only: %i[id title body post_image],
      include: [
        user: { only: %i[id name profile_image] },
        categories: { only: %i[id name] }
      ]
    )
  end

  def show
    render json: @post.to_json(
      only: %i[id title body post_image],
      include: [
        user: { only: %i[id name profile_image] },
        categories: { only: %i[id name] }
      ]
    )
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update_attributes(post_params) && @post.user_id == current_api_user.id
      head :no_content
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    head :no_content if @post.destroy! && @post.user_id == current_api_user.id
  end

  # カテゴリー検索（10ずつ）
  def categories
    @posts = Category.find(params[:id]).posts
    render json: @posts.limit(10).offset(params[:data_id]).to_json(
      only: %i[id title body post_image],
      include: [
        user: { only: %i[id name profile_image] },
        categories: { only: %i[id name] }
      ]
    )
  end

  # いいねが多い順に10個ずつ取得
  def likes
    render json: Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).offset(params[:data_id]).pluck(:post_id)).to_json(
      only: %i[id title body post_image],
      include: [
        user: { only: %i[id name profile_image] },
        categories: { only: %i[id name] }
      ]
    )
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_image, category_ids: []).merge(user_id: current_api_user.id)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
