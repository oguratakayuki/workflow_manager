class AddAuthenticatedUserIdToRequestGrants < ActiveRecord::Migration[5.0]
  def change
    add_column :request_grants, :authenticated_user_id, :integer, after: :authenticatable_user_id
  end
end
