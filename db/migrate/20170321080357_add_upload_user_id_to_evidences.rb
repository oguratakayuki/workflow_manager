class AddUploadUserIdToEvidences < ActiveRecord::Migration[5.0]
  def change
    add_column :evidences, :upload_user_id, :integer, after: :request_id
    add_column :evidences, :type, :string, after: :upload_user_id
  end
end
