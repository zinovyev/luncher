class SetOrdersDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :first_course_id, :integer, default: nil
    change_column :orders, :main_course_id, :integer, default: nil
    change_column :orders, :drink_id, :integer, default: nil
  end
end
