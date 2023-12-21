class CreateUsers < ActiveRecord::Migration[7.0]
  CLIENT_ROLE = 1
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :role_id, null: false, default: CLIENT_ROLE

      t.timestamps
    end
  end
end
