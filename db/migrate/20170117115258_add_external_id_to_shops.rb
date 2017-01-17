class AddExternalIdToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :external_id, :integer, after: :description
    add_column :users, :external_id, :integer, after: :role
  end
end
