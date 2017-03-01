class AddCourseToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :course, :integer
  end
end
