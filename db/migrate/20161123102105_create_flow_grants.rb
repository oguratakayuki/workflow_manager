class CreateFlowGrants < ActiveRecord::Migration[5.0]
  def change
    create_table :flow_grants do |t|
      t.integer :order
      t.string :grant_type

      t.timestamps
    end
  end
end
