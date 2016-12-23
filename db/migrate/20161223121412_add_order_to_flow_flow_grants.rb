class AddOrderToFlowFlowGrants < ActiveRecord::Migration[5.0]
  def change
    remove_column :flow_grants, :order, :integer
    add_column :flow_flow_grants, :order, :integer, after: :flow_grant_id
  end
end
