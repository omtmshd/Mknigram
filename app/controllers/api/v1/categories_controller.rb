class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: %i[children search]

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
    if @category.has_children?
      render json: @category.to_json(
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
      render json: @category.to_json(
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

  # カテゴリー検索（10ずつ）
  # 子カテゴリーがある場合、孫子カテゴリーのPostから検索
  def search
    @posts = if @category.children?
               Post.where(id: PostCategory.where(category_id: @category.descendant_ids).pluck(:post_id))
             else
               @category.posts
             end
    render json: @posts.limit(15).offset(params[:data_id]).to_json(
      only: %i[id title body post_image user_id]
    )
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
