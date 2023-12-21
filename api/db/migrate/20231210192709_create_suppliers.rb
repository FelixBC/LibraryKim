class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.integer :type_id
      t.integer :province_id
      t.integer :city_id
      t.integer :sector_id
      t.string :street

      t.timestamps
    end
  end
end
