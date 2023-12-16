class CreateAddressVsEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :address_vs_employees do |t|
      t.integer :idPeoplevsEmployee
      t.integer :idAddress

      t.timestamps
    end
  end
end
