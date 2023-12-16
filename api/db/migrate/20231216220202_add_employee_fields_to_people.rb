class AddEmployeeFieldsToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :role_id, :integer
    add_column :people, :gender_id, :integer
    add_column :people, :identification_number, :string
    add_column :people, :birth_date, :date
  end
end
