class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_user!, only: %i[create update destroy]
  before_action :set_post, only: %i[show update destroy categories]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  # 15個ずつデータを取得
  def index
    render json: Post.all.limit(15).offset(params[:data_id]).to_json(
      only: %i[id title body post_image user_id]
    )
  end

  def show
    render json: @post.to_json(
      only: %i[id title body post_image user_id],
      include: [
        categories: {
          only: %i[id name]
        }
      ]
    )
  end

  def create
    post = Post.new(post_params)
    if post.save
      head :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.user_id == current_api_user.id && @post.update_attributes(post_params)
      head :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    head :ok if @post.user_id == current_api_user.id && @post.destroy!
  end

  # @post のカテゴリーを返す
  def categories
    render json: @post.categories.to_json(only: %i[id name])
  end

  # いいねが多い順に15個ずつ取得(重複しないよう、さらにsum(id)でorder)
  def likes
    render json: Post.find(Like.group(:post_id).order('count(post_id) desc', 'sum(id) desc').limit(15).offset(params[:data_id]).pluck(:post_id)).to_json(
      only: %i[id title body post_image user_id]
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
