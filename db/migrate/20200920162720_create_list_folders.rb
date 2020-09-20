class CreateListFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :list_folders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
