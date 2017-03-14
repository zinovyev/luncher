class AddOrganizationToPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :prices, :organization_id, :integer

    add_index :prices, :organization_id
  end
end
