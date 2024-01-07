require 'rails_helper'


# spec/controllers/restaurants_controller_spec.rb


RSpec.describe RestaurantsController, type: :controller do
    include Devise::Test::ControllerHelpers
  let(:user) do
    User.create!(
      email: 'testll@example.com',
      password: 123456,
      firstname: 'John',
      lastname: 'Doe',
      address: '123 Main St',
      contactno: '1234567890',
      role: 0 # Assuming 'user' role
    )
  end
  let(:image) { fixture_file_upload("/root/restromanagement/app/assets/images/minus.svg", 'image/svg') }

  let(:restaurant) do
    Restaurant.create!(
      name: 'Example Restaurantl',
      location: '123 Main Sta',
      owner_name: 'John Doke',
      image: image,
      user_id:user.id
    ) # Assuming you have a Restaurant factory
  end
  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'creates a new restaurant' do
      restaurant_params = {
      name: 'Example Restauranta',
      location: '123 Main Sta',
      owner_name: 'John Doel',
      user_id: user.id
    }
      post :create, params: { restaurant: restaurant_params }
      expect(response).to redirect_to Restaurant.last
    end

    it 'renders new template if creation fails' do
      
        restaurant_params = {
          name: nil,
          location: '123 Main St',
          owner_name: 'John Doe',
          user_id: user.id
        }
      post :create, params: { restaurant: restaurant_params }
      expect(response).to render_template :new
    end
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: restaurant.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: restaurant.id }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it 'updates the restaurant' do
      patch :update, params: { id: restaurant.id, restaurant: { name: 'New Name' } }
      expect(response).to redirect_to restaurant
      expect(restaurant.reload.name).to eq('New Name')
    end

    it 'renders edit template if update fails' do
      patch :update, params: { id: restaurant.id, restaurant: { name: nil } }
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the restaurant' do
      delete :destroy, params: { id: restaurant.id }
      expect(response).to redirect_to root_path
      expect(Restaurant.exists?(restaurant.id)).to be_falsey
    end
  end
end


