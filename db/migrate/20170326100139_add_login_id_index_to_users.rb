class AddLoginIdIndexToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :login_id, unique: true
  end
end
