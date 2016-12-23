class CreateJobExecutors < ActiveRecord::Migration[5.0]
  def change
    create_table :job_executors do |t|
      t.integer :job_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end
end
