class DropFlowFlowGrants < ActiveRecord::Migration[5.0]
  def change
    #drop_table :flow_flow_grants
    add_column :flow_grants, :flow_id, :integer, after: :role
    add_column :flow_grants, :position, :integer, after: :flow_id
  end
end
