class Supplier < ApplicationRecord
  enum type: { books: 0, soap: 1, handyman: 2 }

  validates :name, presence: true
end
