class AddAgentIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :client_user_id, :integer, after: :user_id
  end
end
