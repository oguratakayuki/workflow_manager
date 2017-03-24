class AddDisplayableToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :displayable, :boolean, default: true, null: false, after: :description
  end
end
