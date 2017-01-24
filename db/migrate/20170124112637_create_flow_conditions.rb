class CreateFlowConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :flow_conditions do |t|
      t.integer :flow_condition_group_id
      t.string :relation_type
      t.string :compare_type

      t.timestamps
    end
  end
end
