# spec/controllers/line_items_controller_spec.rb
require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
    include Devise::Test::ControllerHelpers
    let(:user) { User.create!( email: 'testljll@example.com',
    password: 123456,
    firstname: 'John',
    lastname: 'Doe',
    address: '123 Main St',
    contactno: '1234567890',
    role: 2) }
    let(:restaurant) { Restaurant.create!(name: 'Test Restaurant', location: 'Test Location', user_id: user.id) }
    let(:food_item) do
      FoodItem.create!(
        name: 'Test Food Item',
        price: 10.0,
        ingredients: 'Test Ingredients',
        restaurant: restaurant,
        user_id: user.id
      )
    end
    let(:cart) { 
   Cart.create!(user_id: user.id)
  }
   

  before do
    sign_in user
    
  end

  describe 'POST #create' do
    it 'creates a new line item' do
      post :create, params: { restaurant_id: restaurant.id, food_item_id: food_item.id }
      expect(response).to redirect_to(cart_path(cart))
      expect(cart.line_items.count).to eq(1)
    end

    it 'increments quantity for existing line item' do
      cart.food_items << food_item
      post :create, params: { restaurant_id: restaurant.id, food_item_id: food_item.id }
      expect(response).to redirect_to(cart_path(cart.reload))
      expect(cart.line_items.find_by(food_item: food_item).quantity).to eq(2)
    end
  end

  describe 'PATCH #add_quantity' do
    it 'increases the quantity of the line item' do
      line_item = cart.line_items.create(food_item: food_item, quantity: 1)
      patch :add_quantity, params: { id: line_item.id }
      expect(response).to redirect_to(cart_path(cart))
      expect(line_item.reload.quantity).to eq(2)
    end
  end

  describe 'PATCH #reduce_quantity' do
    it 'decreases the quantity of the line item' do
      line_item = cart.line_items.create(food_item: food_item, quantity: 2)
      patch :reduce_quantity, params: { id: line_item.id }
      expect(response).to redirect_to(cart_path(cart))
      expect(line_item.reload.quantity).to eq(1)
    end

    it 'does not reduce quantity below 1' do
      line_item = cart.line_items.create(food_item: food_item, quantity: 1)
      patch :reduce_quantity, params: { id: line_item.id }
      expect(response).to redirect_to(cart_path(cart))
      expect(line_item.reload.quantity).to eq(1)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the line item' do
      line_item = cart.line_items.create(food_item: food_item, quantity: 1)
      delete :destroy, params: { id: line_item.id }
      expect(response).to be_successful # Assuming you're not redirecting after destroy
      expect(cart.line_items.count).to eq(0)
    end
  end

  describe 'DELETE #remove' do
    it 'removes the line item from the cart' do
      line_item = cart.line_items.create(food_item: food_item, quantity: 1)
      delete :remove, params: { id: food_item.id }
      expect(response).to redirect_to(cart_path(cart))
      expect(cart.line_items.count).to eq(0)
    end
  end
end
