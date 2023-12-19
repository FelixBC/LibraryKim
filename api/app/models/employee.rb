# app/models/employee.rb
class Employee < ApplicationRecord
  belongs_to :person
  belongs_to :address

  validates :birth_date, presence: true
end
