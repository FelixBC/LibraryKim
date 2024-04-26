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


  enum status: { Prestado: 0, Devuelto: 1}

  validate :book_is_available, on: :create

  private

  def book_is_available
    # Check for books availability based on borrow date and return date and book quantity
    book_inventory = book.quantity
    available_books_based_on_borrow_date = book_inventory - BookCheckout.where(status_id: BookCheckout.statuses[:Prestado]).count

    if available_books_based_on_borrow_date <= 0
      next_available_date = BookCheckout.where(book_id: book.id).where(status_id: BookCheckout.statuses[:Prestado]).where("return_date >= ?", borrow_date).order(:return_date).first&.return_date

      errors.add(:book_id, "No hay libros disponibles para prestar, el próximo libro estará disponible el #{next_available_date}")
    end
  end


end
