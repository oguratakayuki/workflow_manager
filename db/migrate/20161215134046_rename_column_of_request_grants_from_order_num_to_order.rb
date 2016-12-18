class RenameColumnOfRequestGrantsFromOrderNumToOrder < ActiveRecord::Migration[5.0]
  def change
    rename_column :request_grants, :order_num, :order
  end
end
