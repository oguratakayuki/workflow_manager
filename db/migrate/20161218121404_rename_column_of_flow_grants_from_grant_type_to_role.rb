class RenameColumnOfFlowGrantsFromGrantTypeToRole < ActiveRecord::Migration[5.0]
  def change
    rename_column :flow_grants, :grant_type, :role
  end
end
