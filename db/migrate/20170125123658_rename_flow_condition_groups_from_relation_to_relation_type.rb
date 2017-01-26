class RenameFlowConditionGroupsFromRelationToRelationType < ActiveRecord::Migration[5.0]
  def change
    rename_column :flow_condition_groups, :relation, :relation_type
  end
end
