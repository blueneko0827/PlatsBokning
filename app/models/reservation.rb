class Reservation < ApplicationRecord
  belongs_to :desk, foreign_key: :desk_id
  belongs_to :employee, foreign_key: :employee_id

  validates :desk_id, :employee_id, :reservation_date, :reservation_time_from, :reservation_time_to, presence: true
  validates :desk_id, :employee_id, :reservation_date, :reservation_time_from, uniqueness: { scope: [:desk_id, :reservation_date, :reservation_time_from], message: "Reservation already exists for this desk, date, and time" }
end

