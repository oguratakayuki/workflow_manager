class AddFlowIdToFlowConditionGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :flow_condition_groups, :flow_id, :integer, after: :id
  end
end
