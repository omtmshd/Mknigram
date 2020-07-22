class CategoriesController < ApplicationController
  def post_index
    @category = Category.find(params[:id])
    # 子階層がいる場合
    if @category.children?
      # 子カテゴリーを代入。
      @categories = @category.children
    else
      # 兄弟カテゴリーを代入。
      @categories = @category.siblings
      @category = @category.parent
    end
    @posts = Post.all
  end
end
