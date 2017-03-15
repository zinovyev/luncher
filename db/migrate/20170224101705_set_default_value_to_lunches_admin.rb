class SetDefaultValueToLunchesAdmin < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        change_column :users, :lunches_admin, :boolean, default: false 
      end
      dir.down do
        change_column :users, :lunches_admin, :boolean
      end
    end
  end
end
