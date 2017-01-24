class CreateFlowConditionOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :flow_condition_options do |t|
      t.integer :flow_condition_id
      t.string :relation_id

      t.timestamps
    end
  end
end
