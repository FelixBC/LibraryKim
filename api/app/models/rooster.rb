class Rooster < ApplicationRecord
  validates :name, presence: true
  validates :breedId, presence: true
  validates :colorId, presence: true
  validates :loses, presence: true
  validates :wins, presence: true
  validates :strength, presence: true
  validates :resistance, presence: true
  validates :agility, presence: true
  validates :defence, presence: true
  validates :ownersId, presence: true
end
