class RenameFlowConditionRelationTypeToRelatedModel < ActiveRecord::Migration[5.0]
  def change
    rename_column :flow_conditions, :relation_type, :related_model
  end
end
