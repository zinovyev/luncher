class AddCoursesToOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :price_id, :integer
    add_column :orders, :first_course, :integer
    add_column :orders, :main_course, :integer
    add_column :orders, :drink, :integer

    add_timestamps :orders
  end
end
