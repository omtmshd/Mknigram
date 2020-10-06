class Api::V1::ListFoldersController < ApplicationController
  before_action :authenticate_api_user!, only: %i[create index destroy update]
  before_action :set_list_folder, only: %i[show posts update destroy]

  # ログインユーザーのListFolderを返す
  def index
    render json: current_api_user.list_folders.select(:id, :name)
  end

  def show
    render json: @list_folder.to_json(
      only: %i[id name user_id],
      include: [
        lists: { only: [] }
      ]
    )
  end

  def posts
    render json: @list_folder.listed_posts.select(:id, :title, :body, :post_image, :user_id).limit(15).offset(params[:data_id])
  end

  def create
    list_folder = ListFolder.new(list_folder_params)
    if list_folder.save
      head :created
    else
      render json: { errors: list_folder.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @list_folder.update_attributes(list_folder_params)
      head :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    head :ok if @list_folder.destroy! && @list_folder.user_id == current_api_user.id
  end

  private

  def set_list_folder
    @list_folder = ListFolder.find(params[:id])
  end

  def list_folder_params
    params.require(:list_folder).permit(:name).merge(user_id: current_api_user.id)
  end
end
