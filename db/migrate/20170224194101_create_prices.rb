class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.integer :item_id
      t.decimal :value
      t.date :date
    end
  end
end
