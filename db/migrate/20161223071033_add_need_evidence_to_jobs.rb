class AddNeedEvidenceToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :need_evidence, :bool, after: :flow_id
  end
end
