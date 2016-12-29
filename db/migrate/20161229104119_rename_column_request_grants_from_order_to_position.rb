class RenameColumnRequestGrantsFromOrderToPosition < ActiveRecord::Migration[5.0]
  def change
    rename_column :request_grants, :order, :position
  end
end
