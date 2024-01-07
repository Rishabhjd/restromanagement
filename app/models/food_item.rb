class FoodItem < ApplicationRecord
  belongs_to :restaurant,optional:true
    has_many :line_items, dependent: :destroy
    has_many :carts,through: :line_items
    has_one_attached :image

    validates :name,:price,:ingredients,presence:true
    validates :price,numericality:{greater_than: 0}
end
