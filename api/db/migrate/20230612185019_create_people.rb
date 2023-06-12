class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :firstName
      t.text :lastName
      t.integer :phoneNumber

      t.timestamps
    end
  end
end
