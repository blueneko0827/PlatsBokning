class Employee < ApplicationRecord
  has_many :reservations
  has_many :desks, foreign_key: :fixed_employee_id
end
