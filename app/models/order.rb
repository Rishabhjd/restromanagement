class Order < ApplicationRecord
  belongs_to :user
  has_many :restaurants, through: :line_items
  has_many :line_items
  enum status: %i[pending placed]
  validates :address,presence: true
end
