class RenameColumnRequestCostsFromTimeToTimeRequired < ActiveRecord::Migration[5.0]
  def change
    rename_column :request_costs, :time, :time_required
  end
end
