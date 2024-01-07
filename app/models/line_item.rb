class LineItem < ApplicationRecord
belongs_to :food_item
belongs_to :cart,optional: true
belongs_to :order,optional: true
belongs_to :restaurant,optional: true
validates :quantity, presence: true, numericality: { greater_than: 0 }
    def total_price
    self.quantity*self.food_item.price
    end
end
