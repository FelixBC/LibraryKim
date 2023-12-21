class Book < ApplicationRecord
  belongs_to :author
  has_many :book_checkouts, dependent: :destroy

  enum genre: {
    "Fantasy": 0,
    "Science Fiction": 1,
    "Mystery": 2,
    "Thriller": 3,
    "Romance": 4,
    "Western": 5,
    "Dystopian": 6,
    "Contemporary": 7,
    "Historical Fiction": 8,
    "Horror": 9,
    "Young Adult": 10,
    "Children's": 11,
    "Non-fiction": 12,
    "Biography": 13,
    "Memoir": 14,
    "Self-help": 15,
    "Health": 16,
    "Travel": 17,
    "Religion": 18
  }

  def as_json(options = {})
    super(options).deep_transform_keys { |key| key.camelize(:lower) }
                  .merge({
                           rented: book_checkouts.where(status_id: BookCheckout.statuses[:Prestado]).count
                         })
  end

  def to_json
    super(options).deep_transform_keys { |key| key.camelize(:lower) }
  end
end
