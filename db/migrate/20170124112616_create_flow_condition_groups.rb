class CreateFlowConditionGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :flow_condition_groups do |t|
      t.integer :parent_id
      t.string :relation

      t.timestamps
    end
  end
end
