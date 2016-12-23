class CreateEvidences < ActiveRecord::Migration[5.0]
  def change
    create_table :evidences do |t|
      t.integer :request_id
      t.text :comment
      t.string :file_name

      t.timestamps
    end
  end
end
