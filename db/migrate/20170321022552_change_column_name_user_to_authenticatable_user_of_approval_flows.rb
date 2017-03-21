class ChangeColumnNameUserToAuthenticatableUserOfApprovalFlows < ActiveRecord::Migration[5.0]
  def change
    rename_column :approval_flows, :user_id, :authenticatable_user_id
    rename_column :approval_flows, :role,    :authenticatable_role
    rename_column :request_grants, :user_id, :authenticatable_user_id
    rename_column :request_grants, :role,    :authenticatable_role
  end
end
