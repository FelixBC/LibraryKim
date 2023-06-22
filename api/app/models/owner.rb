class Owner < ApplicationRecord
  validates :name, presence: true
  validates :lastName, presence: true
  validates :age, presence: true
  validates :phone, presence: true
  validates :city, presence: true
  validates :identification_number, presence: true
  validates :wins, presence: true
  validates :loses, presence: true
end
