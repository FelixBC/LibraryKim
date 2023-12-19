class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.date :birth_date
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
