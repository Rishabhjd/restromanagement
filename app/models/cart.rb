class Cart < ApplicationRecord
    has_many :line_items,dependent: :destroy
    has_many :food_items,through: :line_items
    
    def has_food_item?(food_item)
        line_items.exists?(food_item: food_item)
      end

    def sub_total
    sum=0
    self.line_items.each do |line_item|
        sum+=line_item.total_price
    end
    return sum
    end
end
