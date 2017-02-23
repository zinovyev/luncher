class AddLoginAndNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :lunches_admin, :boolean
  end
end
