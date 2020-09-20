class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.references :list_folder, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
