class AddRequestIdToRequestGrants < ActiveRecord::Migration[5.0]
  def change
    add_column :request_grants, :request_id, :integer
  end
end
