class RemoveColumnFlowIdFromJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :flow_id, :integer
  end
end
