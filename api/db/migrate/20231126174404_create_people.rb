class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.integer :Identification
      t.string :name
      t.integer :phoneNumber
      t.integer :ID_Genero
      t.date :Fecha_Nacimiento
      t.integer :ID_Address
      t.integer :ID_Email

      t.timestamps
    end
  end
end
