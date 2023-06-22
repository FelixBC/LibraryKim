class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.text :name
      t.integer :age
      t.text :city
      t.bigint :identification_number
      t.bigint :phone
      t.bigint :wins
      t.bigint :loses

      t.timestamps
    end
  end
end
