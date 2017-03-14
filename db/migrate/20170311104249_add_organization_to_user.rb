class AddOrganizationToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :organization, foreign_key: true
    add_column :users, :approved, :boolean

    add_index :users, [:approved, :organization_id]
  end
end
