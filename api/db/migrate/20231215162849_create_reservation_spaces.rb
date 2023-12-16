class CreateReservationSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_spaces do |t|
      t.string :name
      t.integer :capacity
      t.string :availability

      t.timestamps
    end
  end
end
