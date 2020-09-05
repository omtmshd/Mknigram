class Api::V1::CategoriesController < ApplicationController
  before_action :set_post, only: %i[post]

  # 全カテゴリーと第4層カテゴリーの空配列取得
  def index
    render json: Category.where(ancestry: nil).to_json(
      only: %i[id name],
      include: [
        children: {
          only: %i[id name],
          include: [
            children: {
              only: %i[id name],
              include: [
                children: {
                  only: []
                }
              ]
            }
          ]
        }
      ]
    )
  end

  def parents
    render json: Category.where(ancestry: nil).to_json(only: %i[id name])
  end

  def children
    child = Category.find(params[:id]).children
    render json: child.to_json(only: %i[id name]) if child
  end

  def post
    render json: @post.categories.to_json(only: %i[id name])
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
