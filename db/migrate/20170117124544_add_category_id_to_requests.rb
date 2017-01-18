class AddCategoryIdToRequests < ActiveRecord::Migration[5.0]
  def change
    #add_column :requests, :category_id, :integer, after: :user_id
    add_column :requests, :sub_category_id, :integer, after: :category_id
  end
end
