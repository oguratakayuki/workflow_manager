class CreateFlowFlowGrants < ActiveRecord::Migration[5.0]
  def change
    create_table :flow_flow_grants do |t|
      t.integer :flow_id
      t.integer :flow_grant_id

      t.timestamps
    end
  end
end
