# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) do
    User.create!(
      email: 'lsoltestm@example.com',
      password: 123456,
      firstname: 'John',
      lastname: 'Doe',
      address: '123 Main St',
      contactno: '1234567890',
      role: 0 # Assuming 'user' role
    )
  end

   before do
   sign_in user
  end

  describe "GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
 
    it "assigns @users" do
      user = User.create!(
        email: 'aaqtlestm@examsple.com',
        password: 123456,
        firstname: 'Johns',
        lastname: 'Doe',
        address: '123 Main St',
        contactno: '1234567890',
        role: 0 # Assuming 'user' role
      )
      get :index
      expect(assigns(:users)).to include(user)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  # describe 'GET #index' do
  #   it 'returns a success response' do
  #     get :index
  #     expect(response).to be_successful
  #   end

  #   it 'assigns all users as @users' do
  #     users = [user] + Array.new(2) { User.create!(
  #       email: 'test@example.com',
  #       password: 123456,
  #       firstname: 'Johni',
  #       lastname: 'Doe',
  #       address: '123 Main St',
  #       contactno: '1234567890',
  #       role: 0 # Assuming 'user' role
  #     ) }
  #     get :index
  #     expect(assigns(:users)).to match_array(users)
  #   end
  # end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { firstname: 'New Name' } }

      it 'updates the requested user' do
        put :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.firstname).to eq('New Name')
      end

      it 'redirects to the user' do
        put :update, params: { id: user.to_param, user: new_attributes }
        expect(response).to redirect_to(user)
      end

    end
  

    context 'with invalid params' do
      it 'returns a success response (renders edit template)' do
        put :update, params: { id: user.to_param, user: { firstname: '' } }
        expect(response).to be_successful
      end
    end
  end
end
