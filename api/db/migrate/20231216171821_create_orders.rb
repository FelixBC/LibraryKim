class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :trackingNumber
      t.integer :supplierID
      t.integer :userID
      t.decimal :totalOrder
      t.datetime :deliveryDate
      t.datetime :realArrivalDate
      t.integer :paymentMethodID
      t.string :status

      t.timestamps
    end
  end
end
