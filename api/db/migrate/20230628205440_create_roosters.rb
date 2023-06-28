class CreateRoosters < ActiveRecord::Migration[7.0]
  def change
    create_table :roosters do |t|
      t.text :name
      t.integer :breed_id
      t.integer :color_id
      t.integer :wins
      t.integer :loses
      t.integer :strength
      t.integer :resistance
      t.integer :agility
      t.integer :defence
      t.integer :owners_id

      t.timestamps
    end
  end
end
