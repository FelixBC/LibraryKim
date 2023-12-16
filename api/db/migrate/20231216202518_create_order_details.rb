class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.integer :orderID
      t.integer :productTypeID
      t.integer :quantity
      t.decimal :unitPrice

      t.timestamps
    end
  end
end
