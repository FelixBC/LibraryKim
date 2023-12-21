class Reservation < ApplicationRecord
  enum status: { Pendiente: 0, Aprovada: 1, Cancelada: 2 }
end
