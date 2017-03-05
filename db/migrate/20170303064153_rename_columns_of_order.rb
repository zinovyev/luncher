class RenameColumnsOfOrder < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :first_course, :first_course_id
    rename_column :orders, :main_course, :main_course_id
    rename_column :orders, :drink, :drink_id
  end
end
