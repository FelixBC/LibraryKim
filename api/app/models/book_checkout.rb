class BookCheckout < ApplicationRecord
  enum status: { checked_out: 0, returned: 1 }
end
