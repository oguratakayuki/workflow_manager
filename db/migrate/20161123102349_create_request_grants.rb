class CreateRequestGrants < ActiveRecord::Migration[5.0]
  def change
    create_table :request_grants do |t|
      t.integer :flow_grant_id
      t.integer :order_num
      t.integer :grant_zen_user_id
      t.integer :status

      t.timestamps
    end
  end
end
