class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_api_user!

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  def create
    if current_api_user.active_relationships.create(relationships_params)
      head :create
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_api_user.unfollow(@user)
      head :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def relationships_params
    params.require(:relationship).permit(:followed_id, :follower_id)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
