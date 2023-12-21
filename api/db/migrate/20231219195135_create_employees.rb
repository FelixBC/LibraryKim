class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :identification
      t.string :email
      t.string :phone_number
      t.date :birth_date
      t.float :salary
      t.integer :gender_id
      t.integer :province_id
      t.integer :city_id
      t.integer :sector_id
      t.string :street

      t.timestamps
    end
  end
end
