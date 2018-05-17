class Ticket < ApplicationRecord
  validates :name, :description, presence: true
  validates :description, length: {minimum: 10, message: ' must be at least 10 characters long.'}
  belongs_to :project
end
