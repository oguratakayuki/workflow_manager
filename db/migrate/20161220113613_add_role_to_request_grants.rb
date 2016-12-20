class AddRoleToRequestGrants < ActiveRecord::Migration[5.0]
  def change
    add_column :request_grants, :role, :string, after: :order
  end
end
