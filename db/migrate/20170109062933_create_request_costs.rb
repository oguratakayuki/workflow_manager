class CreateRequestCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :request_costs do |t|
      t.integer :request_id
      t.integer :price
      t.time :time
      t.string :person_number
      t.string :cost_price_type

      t.timestamps
    end
  end
end
