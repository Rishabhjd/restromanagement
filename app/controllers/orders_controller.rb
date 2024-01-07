class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
  if current_user.member?
    @orders=Order.accessible_by(current_ability).order(:id)
  else
 
   @restaurant=Restaurant.find(params[:restaurant_id])
   if current_user.owner?
#  Order.each do |s| s.line_items.each do |f| FoodItem.where(id: f.food_item_id).each do |restauran|  @match_restaurant_id=restauran.restaurant_id end end end
 byebug
@orders=@restaurant.orders.all
end
  end
  end

  def show
    @restaurant=Restaurant.find(params[:restaurant_id])
    @order = Order.find(params[:id])
  end

  def fetch_orders_for_restaurant
    restaurant_id = params[:restaurant_id]  # You might get this from params or another source
  
    # Find the restaurant by ID
    restaurant = Restaurant.find(restaurant_id)
  
    # Fetch orders associated with the restaurant
    @orders = restaurant.orders
  
    # You can now use @orders in your views or other processing.
  end
  
  def new
    
   @order = Order.new
  end
  
  def accept
  @order=Order.find(params[:id])
  # authorize! :accept ,@order
  @order.status="placed"
  if @order.update(status:"placed")
    redirect_to orders_path,notice:'Order was successfully accepted'
  else 
    render :show
  end 
  end
  
  def create
  @order=Order.new(order_params)
  @current_cart.line_items.each do|item|
  @order.line_items<<item
  item.cart_id=nil
  end
  @order.user_id=current_user.id
  # @order.restaurant_id= session['restaurant']["id"]
 
  # session['restaurant']=nil
 debugger
  @order.save

  Cart.destroy(session[:cart_id])
  session[:cart_id]=nil
  redirect_to root_path
end

private
def order_params
params.require(:order).permit(:name,:email,:address,:user_id,:restaurant_id)
end




end
