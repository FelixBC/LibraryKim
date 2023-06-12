class Person < ApplicationRecord
  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :phoneNumber, presence: true
end
