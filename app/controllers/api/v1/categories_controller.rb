class Api::V1::CategoriesController < ApplicationController
  before_action :set_post, only: %i[post]

  # 全カテゴリー取得
  def index
    render json: Category.where(ancestry: nil).to_json(
      only: %i[id name],
      include: [
        children: {
          only: %i[id name],
          include: [
            children: {
              only: %i[id name]
            }
          ]
        }
      ]
    )
  end

  def parents
    render json: Category.where(ancestry: nil).to_json(
      methods: [:posts_count],
      only: %i[id name]
    )
  end

  # 子カテゴリーがあれば返し、なければ兄弟カテゴリーを返す。
  def children
    category = Category.find(params[:id])
    if category.has_children?
      render json: category.to_json(
        methods: [:posts_count],
        only: %i[id name],
        include: [
          children: {
            methods: [:posts_count],
            only: %i[id name]
          },
          parent: {
            methods: [:posts_count],
            only: %i[id name]
          }
        ]
      )
    else
      render json: category.to_json(
        methods: [:posts_count],
        only: %i[id name],
        include: [
          siblings: {
            methods: [:posts_count],
            only: %i[id name]
          },
          parent: {
            methods: [:posts_count],
            only: %i[id name]
          }
        ]
      )
    end
  end

  def post
    render json: @post.categories.to_json(only: %i[id name])
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
