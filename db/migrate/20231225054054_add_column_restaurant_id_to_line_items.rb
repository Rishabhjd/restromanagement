class AddColumnRestaurantIdToLineItems < ActiveRecord::Migration[7.1]
  def change
    add_column :line_items, :restaurant_id, :integer
  end
end
