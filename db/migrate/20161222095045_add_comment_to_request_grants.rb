class AddCommentToRequestGrants < ActiveRecord::Migration[5.0]
  def change
    add_column :request_grants, :comment, :string, after: :status
  end
end
