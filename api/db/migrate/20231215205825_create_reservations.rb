class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :event_id
      t.integer :client_id
      t.integer :status_id

      t.timestamps
    end
  end
end
