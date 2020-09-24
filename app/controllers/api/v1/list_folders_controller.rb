class Api::V1::ListFoldersController < ApplicationController
  before_action :authenticate_api_user!, only: %i[create index destroy]

# ログインユーザーのリスト
  def index
    render json: current_api_user.list_folders.to_json(
      only: %i[id name]
    )
  end

  # ユーザーのリストを返す
  def show
    render json: User.find(params[:id]).list_folders.to_json(
      only: %i[id name]
    )
  end

  def posts
  end

  def create
    list_folder = ListFolder.new(list_folder_params)
    if list_folder.save
      head :created
    else
      render json: { errors: list_folder.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def list_folder_params
    params.require(:list_folder).permit(:name).merge(user_id: current_api_user.id)
  end
end
