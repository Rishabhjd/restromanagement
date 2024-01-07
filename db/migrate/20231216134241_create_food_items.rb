class CreateFoodItems < ActiveRecord::Migration[7.1]
  def change
    create_table :food_items do |t|
      t.string :name
      t.integer :price
      t.string :ingredients

      t.timestamps
    end
  end
end
