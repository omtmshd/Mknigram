class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_user!, only: %i[create update destroy]
  before_action :set_post, only: %i[show update destroy]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    render json: Post.all.limit(5).offset(params[:data_id]).to_json(
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
