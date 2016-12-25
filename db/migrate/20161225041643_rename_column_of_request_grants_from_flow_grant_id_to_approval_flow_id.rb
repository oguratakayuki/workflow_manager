class RenameColumnOfRequestGrantsFromFlowGrantIdToApprovalFlowId < ActiveRecord::Migration[5.0]
  def change
    rename_column :request_grants, :flow_grant_id, :approval_flow_id
  end
end
