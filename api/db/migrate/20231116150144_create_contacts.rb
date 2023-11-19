class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.integer :ID_Email

      t.timestamps
    end
  end
end
