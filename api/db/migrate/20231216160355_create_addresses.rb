class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :idCountry
      t.integer :idProvincia
      t.integer :idCity
      t.integer :idSector
      t.string :street

      t.timestamps
    end
  end
end
