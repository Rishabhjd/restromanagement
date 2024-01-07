require 'rails_helper'


# spec/controllers/restaurants_controller_spec.rb


RSpec.describe FoodItemsController, type: :controller do
    include Devise::Test::ControllerHelpers
    let(:user) { User.create!( email: 'testlll@example.com',
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
  
    before do
      sign_in user
     
    end
  
    describe 'GET #index' do
      it 'renders the index template' do
        get :index, params: { restaurant_id: restaurant.id }
        expect(response).to render_template :index
        expect(assigns(:food_items)).to eq([food_item])
      end
    end
  
    describe 'GET #new' do
      it 'renders the new template' do
        get :new, params: { restaurant_id: restaurant.id }
        expect(response).to render_template :new
        expect(assigns(:food_item)).to be_a_new(FoodItem)
      end
    end
  
    describe 'POST #create' do
      it 'creates a new food item' do
        food_item_params = {
          name: 'New Food Item',
          price: 15.0,
          ingredients: 'New Ingredients',
          restaurant_id: restaurant.id
        }
  
        post :create, params: { restaurant_id: restaurant.id, food_item: food_item_params }
        
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq('Food item was successfully created.')
      end
  
      it 'renders new template if creation fails' do
        post :create, params: { restaurant_id: restaurant.id, food_item: { name: nil } }
        expect(response).to render_template :new
      end
    end

    describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { restaurant_id: restaurant.id, id: food_item.id }
      expect(response).to render_template :show
      expect(assigns(:food_item)).to eq(food_item)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { restaurant_id: restaurant.id, id: food_item.id }
      expect(response).to render_template :edit
      expect(assigns(:food_item)).to eq(food_item)
    end
  end

  describe 'PATCH #update' do
    it 'updates the food item' do
      patch :update, params: { restaurant_id: restaurant.id, id: food_item.id, food_item: { name: 'New Name' } }
      expect(response).to redirect_to restaurant_food_items_path
      expect(flash[:notice]).to be_present
      expect(food_item.reload.name).to eq('New Name')
    end

    it 'renders edit template if update fails' do
      patch :update, params: { restaurant_id: restaurant.id, id: food_item.id, food_item: { name: nil } }
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the food item' do
      delete :destroy, params: { restaurant_id: restaurant.id, id: food_item.id }
      expect(response).to redirect_to restaurant_food_items_path
      expect(flash[:notice]).to be_present
      expect(FoodItem.exists?(food_item.id)).to be_falsey
    end
  end
  
end