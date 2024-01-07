class AddColumnUserIdToFoodItems < ActiveRecord::Migration[7.1]
  def change
    add_column :food_items, :user_id, :integer
  end
end
