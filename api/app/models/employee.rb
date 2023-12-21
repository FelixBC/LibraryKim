# app/models/employee.rb
class Employee < ApplicationRecord
  enum gender: { male: 0, female: 1, unspecified: 2 }
  belongs_to :province
  belongs_to :city
  belongs_to :sector

  validates_presence_of :name,
                        :province_id,
                        :city_id,
                        :sector_id,
                        :street,
                        :birth_date,
                        :salary
end
