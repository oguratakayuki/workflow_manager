class RenameJobsToFlows < ActiveRecord::Migration[5.0]
  def change
    rename_table :jobs, :flows
    rename_column :approval_flows, :job_id, :flow_id
    rename_column :requests,           :job_id, :flow_id
    rename_column :job_executors,  :job_id, :flow_id
    rename_table :job_executors, :flow_executors
  end
end
