class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :clients, through: :reservations, source: :client
end
