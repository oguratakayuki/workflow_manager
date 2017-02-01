class AddRelationValueToFlowConditionOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :flow_condition_options, :compare_value, :integer, after: :relation_id
  end
end
