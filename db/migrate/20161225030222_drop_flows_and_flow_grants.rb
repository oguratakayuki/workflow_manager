class DropFlowsAndFlowGrants < ActiveRecord::Migration[5.0]
  def change
    drop_table :flow_grants
    drop_table :flows
  end
end
