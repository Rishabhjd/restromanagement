require 'rails_helper'

RSpec.describe LineItem, type: :model do
  
  it{should belong_to(:food_item)}
  it{ is_expected.to belong_to(:cart)}
  it{ is_expected.to belong_to(:order)}
  it{ is_expected.to belong_to(:restaurant)}
  it{validate_presence_of(:quantity)}
  it{validate_numericality_of(:quantity).is_greater_than(0)}
 
  #  it "total_price"  do
 
  # quantity=assigns(line_item.quantity,1) 
  # food_item.price=assigns(line_item.food_item.price,12)
  # expect (:total_price).to be(line_item.quantity*line_item.food_item.price)
  # end

  # it "total_price" do
  #   idea = Idea.create!(name: "My Awesome Idea Name")
  #   comment = Comment.create!(
  #     user_name: "My name",
  #     body: "My helpful comment",
  #     idea: idea # Link the comment to the idea
  #   )

  #   expect(comment.idea).to eq(idea)
  # end
  it "total price" do
    food_item = FoodItem.create!(name: "Burger",price:30,ingredients:"toor daal")
    line_item = LineItem.create!(
      quantity: 1,
    
      food_item: food_item # Link the comment to the idea
    )

    expect(line_item.total_price).to eq(line_item.quantity*line_item.food_item.price)
  end
end
