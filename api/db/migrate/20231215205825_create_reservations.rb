class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :name
      t.integer :reservation_space_id
      t.string :description

      t.timestamps
    end
  end
end
