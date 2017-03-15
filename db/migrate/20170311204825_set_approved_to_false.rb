class SetApprovedToFalse < ActiveRecord::Migration[5.0]
  def change
    revert do
      reversible do |dir|
        dir.up do
          change_column :users, :approved, :boolean, default: false
        end
        dir.down do
          change_column :users, :approved, :boolean
        end
      end
    end
  end
end
