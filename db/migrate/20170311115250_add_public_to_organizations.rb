class AddPublicToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :public, :boolean, default: true
    add_index :organizations, :public
  end
end
