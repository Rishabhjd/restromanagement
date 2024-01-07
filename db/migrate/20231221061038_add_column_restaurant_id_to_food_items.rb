class AddColumnRestaurantIdToFoodItems < ActiveRecord::Migration[7.1]
  def change
    add_column :food_items, :restaurant_id, :integer
  end
end
