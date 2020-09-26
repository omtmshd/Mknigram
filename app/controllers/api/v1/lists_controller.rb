class Api::V1::ListsController < ApplicationController
  before_action :authenticate_api_user!, only: %i[create destroy]

  # Post の List(id)を返す
  def index
    render json: Post.find(params[:id]).lists.to_json(
      only: [:id],
    )
  end

  # ListFolderのListを返す
  def show
    render json: ListFolder.find(params[:id]).lists.to_json(
      only: %i[id post_id]
    )
  end

  def create
    List.create!(list_params)
    head :created
  end

  def destroy
    @list = List.find(params[:id])
    head :ok if @list.destroy! && @list.list_folder.user.id == current_api_user.id
  end

  private

  def list_params
    params.require(:list).permit(:post_id, :list_folder_id)
  end
end
