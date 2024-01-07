class Restaurant < ApplicationRecord
    has_many :food_items,dependent: :destroy
    has_and_belongs_to_many :users, join_table: "restaurants_users"
    has_many :line_items
    has_many :orders, through: :line_items
    

   validates :name,:location,presence: true

    has_one_attached :image
   
end
