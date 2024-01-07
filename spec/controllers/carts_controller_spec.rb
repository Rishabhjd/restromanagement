# spec/controllers/carts_controller_spec.rb
require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { User.create!( email: 'testljll@example.com',
  password: 123456,
  firstname: 'John',
  lastname: 'Doe',
  address: '123 Main St',
  contactno: '1234567890',
  role: 2) } 
  let(:cart) { Cart.create!(user_id: user.id) }

  before do
    sign_in user
    
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show
      expect(response).to render_template :show
      expect(assigns(:cart)).to eq(cart)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the cart and redirects to root path' do
      delete :destroy
      expect(response).to redirect_to root_path
      expect(session[:cart_id]).to be_nil
      expect(Cart.exists?(cart.id)).to be_falsey
    end
  end
end
