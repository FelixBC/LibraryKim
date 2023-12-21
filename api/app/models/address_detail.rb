# app/models/address.rb
class AddressDetail < ApplicationRecord

  belongs_to :employee, optional: true
  # belongs_to :supplier, optional: true

  validates :province_id, presence: true
  validates :city_id, presence: true
  validates :sector_id, presence: true
  validates :street, presence: true

  # Add any other validations and methods as needed
end
