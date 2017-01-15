class AddInitialCostToRequestCosts < ActiveRecord::Migration[5.0]
  def change
    add_column :request_costs, :initial_cost, :integer
  end
end
