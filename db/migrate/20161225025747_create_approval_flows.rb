class CreateApprovalFlows < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_flows do |t|
      t.integer :job_id
      t.integer :position
      t.string :role
      t.integer :user_id

      t.timestamps
    end
  end
end
