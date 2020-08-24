class Api::V1::UsersController < ApiController
  before_action :authenticate_user!
  before_action :set_user, only: %i[update show following]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    users = User.all.to_json
    render json: users
  end

  def show
    render json: @user.to_json(include: [posts: {include: [:user, categories: { only: %i[id name] }]}])
  end

  def update
    if @user.update_attributes(user_params)
      head :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def current
    render json: current_user
  end

  def following
    render json: @user.to_json(include: [:following, :followers])
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
