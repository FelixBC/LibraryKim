class CreatePeopleVsEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :people_vs_employees do |t|
      t.integer :idPeople
      t.integer :idEmpleado

      t.timestamps
    end
  end
end
