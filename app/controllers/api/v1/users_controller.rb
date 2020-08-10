class Api::V1::UsersController < ApiController
  # before_action :authenticate_user!, only: %i[index edit update destroy following followers]
  before_action :set_user, only: %i[update show]

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    users = User.select(:id, :name, :profile, :profile_image)
    render json: users
  end

  def show
    render json: @user
  end

  def update
    if @user.update_attributes(user_params)
      head :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
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
