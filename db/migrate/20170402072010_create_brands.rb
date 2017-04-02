class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.integer :external_id

      t.timestamps
    end
    add_column :shops, :brand_id, :integer, after: :name
  end
end
