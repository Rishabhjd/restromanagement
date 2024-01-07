require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { should have_many(:line_items).dependent(:destroy) }
  it { should have_many(:food_items).through(:line_items) }

  let(:cart) { Cart.create }

  describe '#has_food_item?' do
    it 'returns true if the cart has the specified food item' do
      food_item = FoodItem.create(name: 'Example Food Item', price: 10.0)
      line_item = LineItem.create(cart: cart, food_item: food_item, quantity: 1)

      expect(cart.has_food_item?(food_item)).to be_truthy
    end

    it 'returns false if the cart does not have the specified food item' do
      other_food_item = FoodItem.create(name: 'Other Food Item', price: 15.0)

      expect(cart.has_food_item?(other_food_item)).to be_falsey
    end
  end

  describe '#sub_total' do
    it 'calculates the correct sub-total for the cart' do
      
      food_item1 = FoodItem.create!(name: 'Food Item 1', price: 10.0,ingredients:"tofood1")
      food_item2 = FoodItem.create!(name: 'Food Item 2', price: 15.0,ingredients:"tofood2")

      line_item1 = LineItem.create!(cart: cart, food_item: food_item1, quantity: 2)
      line_item2 = LineItem.create!(cart: cart, food_item: food_item2, quantity: 1)

       expected_sub_total = (food_item1.price * 2) + (food_item2.price * 1)

      expect(cart.sub_total).to eq(expected_sub_total)
    end

    it 'returns 0 when the cart has no line items' do
      expect(cart.sub_total).to eq(0)
    end
  end
end
