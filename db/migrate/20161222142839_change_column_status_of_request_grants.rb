class ChangeColumnStatusOfRequestGrants < ActiveRecord::Migration[5.0]
  def change
    change_column :request_grants, :status, :string
  end
end
