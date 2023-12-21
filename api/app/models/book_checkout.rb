class BookCheckout < ApplicationRecord
  belongs_to :book
  belongs_to :client, class_name: "User", foreign_key: "client_id"

  enum status: { Prestado: 0, Devuelto: 1 }
end
