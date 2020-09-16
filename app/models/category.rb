class Category < ApplicationRecord
  has_ancestry
  has_many :post_category
  has_many :posts, through: :post_category
  default_scope -> { order(:id) }

  def posts_count
    # 子カテゴリーがある場合
    if self.children?
      # 子カテゴリー、孫カテゴリーのPostを返す
      return Post.where(id: PostCategory.where(category_id: self.descendant_ids).pluck(:post_id)).count

      子カテゴリーがない場合
    else
      # 自身のPostレコードを返す
      return self.posts.count
    end
  end

end
