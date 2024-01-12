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
    role: 0) }
    
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
     
      Cart.find_or_create_by!(user_id:user.id)
     
  }
  
  let(:line_item) { 
  
    LineItem.create!(cart_id: cart.id, food_item_id: food_item.id, quantity: 1, restaurant_id: restaurant.id) }

    before do
      sign_in user
    end

  

  describe 'POST #create' do
  it 'creates a new line item' do
    post :create, params: { food_item_id: food_item.id, restaurant_id: 1 }
    expect(response).to redirect_to cart_path(cart)
  end

  it 'updates the quantity of an existing line item' do
    cart.food_items << food_item
    post :create, params: { food_item_id: food_item.id, restaurant_id: 1 }
    expect(response).to redirect_to cart_path(cart)
  end
end

# describe 'GET #index' do
#   it 'renders the index template' do
#     get :index
#     expect(response).to render_template :index
#   end
# end

# describe 'GET #show' do
#   it 'renders the show template' do
#     get :show, params: { id: line_item.id }
#     expect(response).to render_template :show
#   end
# end

# describe 'GET #edit' do
#   it 'renders the edit template' do
#     get :edit, params: { id: line_item.id }
#     expect(response).to render_template :edit
#   end
# end

# describe 'PATCH #update' do
#   it 'updates the line item' do
#     patch :update, params: { id: line_item.id, line_item: { quantity: 2 } }
#     expect(response).to redirect_to cart_path(cart)
#     expect(line_item.reload.quantity).to eq(2)
#   end

#   it 'renders edit template if update fails' do
#     patch :update, params: { id: line_item.id, line_item: { quantity: nil } }
#     expect(response).to render_template :edit
#   end
# end

describe 'PATCH #add_quantity' do
  it 'increases the quantity of the line item' do
    patch :add_quantity, params: { id: line_item.id }
    expect(response).to redirect_to cart_path(cart)
    expect(line_item.reload.quantity).to eq(2)
  end
end

describe 'PATCH #reduce_quantity' do
  it 'decreases the quantity of the line item' do
    patch :reduce_quantity, params: { id: line_item.id }
    expect(response).to redirect_to cart_path(cart)
    expect(line_item.reload.quantity).to eq(1)
  end
end

describe 'DELETE #destroy' do
  it 'destroys the line item' do
    delete :destroy, params: { id: line_item.id }
    expect(response).to redirect_to cart_path(cart)
    expect(LineItem.exists?(line_item.id)).to be_falsey
  end
end
end
