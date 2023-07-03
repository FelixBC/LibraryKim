class Owners < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true
  validates :phone, presence: true
  validates :city, presence: true
  validates :identificationNumber, presence: true
  validates :wins, presence: true
  validates :loses, presence: true
end
