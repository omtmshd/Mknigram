class Category < ApplicationRecord
  has_ancestry
  has_many :post_category
  has_many :posts, through: :post_category
  default_scope -> { order(:id) }

  def posts_count
    if children?
      # 子カテゴリーがある場合
      # 子カテゴリー、孫カテゴリーのPostを返す
      Post.where(id: PostCategory.where(category_id: descendant_ids).pluck(:post_id)).count
    else
      # 子カテゴリーがない場合
      # 自身のPostレコードを返す
      posts.count
    end
  end
end
