class Employee < ApplicationRecord
  has_many :reservations
  has_many :desks, foreign_key: :desk_id
end
