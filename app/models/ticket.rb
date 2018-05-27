class Ticket < ApplicationRecord
  validates :name, :description, presence: true
  validates :description, length: {minimum: 10, message: ' must be at least 10 characters long.'}
  belongs_to :project
  belongs_to :author, class_name: "User"
end
