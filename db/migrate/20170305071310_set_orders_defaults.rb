class SetOrdersDefaults < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        change_column :orders, :first_course_id, :integer, default: nil
        change_column :orders, :main_course_id, :integer, default: nil
        change_column :orders, :drink_id, :integer, default: nil
      end
      dir.down do
        change_column :orders, :first_course_id, :integer
        change_column :orders, :main_course_id, :integer
        change_column :orders, :drink_id, :integer
      end
    end
  end
end
