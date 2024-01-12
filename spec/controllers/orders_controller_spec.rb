require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
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
let (:order){
    Order.create!(address:"Sant florida 1098",user_id:user.id)
}
    before do
      sign_in user
    end   


  describe 'GET #index' do
  it 'renders the index template' do
    get :index,params:{ restaurant_id: restaurant.id }
    expect(response).to render_template :index
  end
end

  describe 'GET #show' do
  it 'renders the show template' do
    get :show, params: { id: order.id,restaurant_id: restaurant.id }
    expect(response).to render_template :show
  end
end

describe 'GET#new' do
it 'render the new template' do
    get :new
    expect(response).to render_template :new
end
end

describe 'Post#accept' do
it 'update the status of orders' do
post :accept,params:{id:order.id ,restaurant_id: restaurant.id }
expect(response).to redirect_to orders_path
end
#   it 'renders show template if update fails' do
#     order.status=nil
#     post :accept,params:{id:order.id ,restaurant_id: restaurant.id }
#     expect(response).to render_template :show
#   end
end

describe 'POST #create' do
  it 'creates a new order' do
    post :create, params: { 
        order: {
        address:"london oriana",
        user_id:user.id
      } }
    expect(response).to redirect_to root_path
  end

  it 'updates the quantity of an existing line item' do
    order.line_items << line_item
    post :create, params: { 
        order: {
        address:"london oriana",
        user_id:user.id
      } }
    expect(response).to redirect_to root_path
  end
end



end