# app/models/person.rb
class Person < ApplicationRecord
  has_one :address
  has_one :employee

  validates :identification, presence: true
  validates :name, presence: true

  # Add any other validations and methods as needed
end
