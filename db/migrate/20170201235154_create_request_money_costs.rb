class CreateRequestMoneyCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :request_money_costs do |t|
      t.integer :request_id
      t.string :type
      t.integer :cost_value
      t.text :annotation

      t.timestamps
    end
  end
end
