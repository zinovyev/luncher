class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :price_id
      t.integer :user_id
    end
  end
end
