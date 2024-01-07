class AddColumnRestaurantIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :restaurant_id, :integer
  end
end
