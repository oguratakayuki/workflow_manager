class RenameZenUserIdToUserIdOnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :requests, :zen_user_id, :user_id
  end
end
