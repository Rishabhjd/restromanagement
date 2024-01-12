class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart
  end

  def destroy
    @cart = current_cart
    @cart.destroy
   
    redirect_to root_path
  end

  private

  def current_cart
    @current_cart ||= Cart.find_or_create_by(user: current_user)
  end
end

