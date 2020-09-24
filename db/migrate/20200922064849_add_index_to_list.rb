class AddIndexToList < ActiveRecord::Migration[6.0]
  def change
    add_index :lists, [:list_folder_id, :post_id], :name => 'unique_list_folder_post', :unique => true
  end
end
