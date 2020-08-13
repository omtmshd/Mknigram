class AddIndexToLike < ActiveRecord::Migration[6.0]
  def change
    add_index :likes, [:user_id, :post_id], :name => 'unique_user_post', :unique => true
  end
end
