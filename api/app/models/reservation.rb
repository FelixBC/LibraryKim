class Reservation < ApplicationRecord
  enum status: { Pendiente: 0, Aprovada: 1, Cancelada: 2 }

  belongs_to :client, class_name: "User", foreign_key: "client_id"
  belongs_to :event, class_name: "Event", foreign_key: "event_id"
end
