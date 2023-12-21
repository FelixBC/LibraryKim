class Province < ApplicationRecord
  has_many :cities
  has_many :sectors, through: :cities
end
