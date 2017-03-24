class AddAuthenticatableTypToApprovalFlows < ActiveRecord::Migration[5.0]
  def change
    add_column :approval_flows, :authenticatable_type, :string, after: :position
    add_column :request_grants, :authenticatable_type, :string, after: :position
  end
end
