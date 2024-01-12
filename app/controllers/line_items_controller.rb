class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    chosen_food_item = FoodItem.find(params[:food_item_id])
    current_cart = current_user.cart || Cart.create(user: current_user)

    if current_cart.food_items.include?(chosen_food_item)
      @line_item = current_cart.line_items.find_by(food_item: chosen_food_item)
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.food_item = chosen_food_item
    end

    @line_item.restaurant_id = params[:restaurant_id]
    @line_item.save

    redirect_to cart_path(current_cart)
  end

  # def index
  
  #   @line_items = current_user.cart.line_items
  # end

  # def show
    
  #   @line_item = LineItem.find(params[:id])
  # end

  # def edit
  #   @line_item = LineItem.find(params[:id])
  # end

  # def update
  #   @line_item = LineItem.find(params[:id])

  #   if @line_item.update(line_item_params)
  #     redirect_to cart_path(current_user.cart), notice: 'Line item was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  
  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    redirect_to cart_path(current_cart)
  end
  
  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    end
    @line_item.save
    redirect_to cart_path(current_cart)
  end

  
  def destroy
  
    @line_item = current_cart.line_items.find { |line_item| line_item['food_item_id'] == params[:id].to_i }
    @line_item.destroy

    redirect_to cart_path(current_user.cart), notice: 'Line item was successfully removed.'
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity, :food_item_id, :cart_id, :restaurant_id)
  end
end
