# app/models/address.rb
class Address < ApplicationRecord
  belongs_to :person

  validates :idCountry, presence: true
  validates :idProvincia, presence: true
  validates :idCity, presence: true
  validates :idSector, presence: true
  validates :street, presence: true

  # Add any other validations and methods as needed
end
