class AddIsDefaultToFlows < ActiveRecord::Migration[5.0]
  def change
    add_column :flows, :is_default, :boolean, after: :need_evidence
  end
end
