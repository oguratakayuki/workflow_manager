class CreateRequestHumanCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :request_human_costs do |t|
      t.integer :request_id
      t.string :type
      t.integer :time_required
      t.integer :number_of_people
      t.text :annotation

      t.timestamps
    end
  end
end
