class LineItemsController < ApplicationController
  before_action :authenticate_user!
def create
    # Find associated  and current cart
    chosen_food_item = FoodItem.find(params[:food_item_id])
    current_cart = @current_cart
  
    # If cart already has this  then find the relevant line_item and iterate quantity otherwise create a new line_item for this 
    if current_cart.food_items.include?(chosen_food_item)
      # Find the line_item with the chosen_
      @line_item = current_cart.line_items.find_by(:food_item_id => chosen_food_item)
      # Iterate the line_item's quantity by one
    
      @line_item.quantity += 1
     
    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.food_item = chosen_food_item
      
    end
    # byebug
  @line_item.restaurant_id=params[:restaurant_id]
    # Save and redirect to cart show path
    @line_item.save

    redirect_to cart_path(current_cart)
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end
  
  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    end
    @line_item.save
    redirect_to cart_path(@current_cart)
  end
  def destroy
    @line_item = LineItem.find(params[:id])
  @line_item.destroy
 
  end

  def remove
   
    @line_item = @current_cart.line_items.find { |line_item| line_item['food_item_id'] == params[:id].to_i }
    @line_item.destroy
    redirect_to cart_path, notice: 'Item removed from cart.'
  end
  
  
  private
    def line_item_params
      params.require(:line_item).permit(:quantity,:food_item_id, :cart_id,:restaurant_id)
    end
end
