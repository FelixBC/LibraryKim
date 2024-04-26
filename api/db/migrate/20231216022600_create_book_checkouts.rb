class CreateBookCheckouts < ActiveRecord::Migration[7.0]
  def change
    create_table :book_checkouts do |t|
      t.integer :book_id
      t.integer :client_id
      t.integer :status_id
      t.date :borrow_date
      t.date :return_date

      t.timestamps
    end
  end
end
