class Api::V1::LikesController < ApiController

  before_action :authenticate_user!

  def index
    render json: Like.filter_by_post(params[:post_id]).select(:id, :user_id, :post_id)
  end

  def create
    current_user.likes.create!(likes_params)
    head :created
  end

  def destroy
    current_user.likes.find(params[:id]).destroy!
    head :ok
  end

  private

  def likes_params
    params.require(:like).permit(:post_id)
  end
end
