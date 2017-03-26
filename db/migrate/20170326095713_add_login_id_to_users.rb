class AddLoginIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :login_id, :string, after: :name
    remove_column :users, :external_id
  end
end
