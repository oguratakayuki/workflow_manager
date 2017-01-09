class ChangeColumnTypeOfRequestCostsOfTimeRequiredFromTimeToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :request_costs, :time_required, :integer
  end
end
