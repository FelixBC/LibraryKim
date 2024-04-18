class BookCheckout < ApplicationRecord
  belongs_to :book
  belongs_to :client, class_name: "User", foreign_key: "client_id"
  validate :book_available

  enum status: { lent: 0, returned: 1 }


  private
  def book_available
    # calculate books currently lent
    currently_book_count = book_checkouts.where(status_id: BookCheckout.statuses[:lent]).count
    # calculate books owned
    # validate books owned > booksLent
    out_of_stock = currently_book_count == quantity
    if out_of_stock
      error.add(:book_id, "Out of stock")
    end
  end

end
