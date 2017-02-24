class SetDefaultValueToLunchesAdmin < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :lunches_admin, :boolean, default: false 
  end
end
