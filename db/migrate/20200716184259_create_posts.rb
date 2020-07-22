class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.string :post_image, null: false
      t.text :title, null: false

      t.timestamps
    end
    add_index :posts, %i[user_id created_at]
  end
end
