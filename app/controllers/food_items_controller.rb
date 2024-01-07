class FoodItemsController < ApplicationController
  before_action :set_restaurant, only: [:new, :create,:index,:edit,:update,:destroy,:show]
  load_and_authorize_resource
 before_action :authenticate_user!
  def index
    @food_items=@restaurant.food_items.all
  end
   
  def new
    @food_item = @restaurant.food_items.build
  end

  def create
    @food_item = @restaurant.food_items.build(food_item_params)
    @food_item.user_id=@restaurant.user_id
    if @food_item.save
       redirect_to root_path, notice: 'Food item was successfully created.'
    else
      render :new
     end
  end

  def show
   @food_item=@restaurant.food_items.find(params[:id])
   session[:food_items] ||= {}
  #  @line_item.restaurant_id=@restaurant.id
  end
 
  
  def edit
   @food_item = @restaurant.food_items.find(params[:id])
   
  end

  def update
    @food_item = @restaurant.food_items.find(params[:id])
    if @food_item.update(food_item_params)
      flash[:notice]="Food Items Updated Successfully"
      redirect_to restaurant_food_items_path
    else
      render :edit
    end
  end

  def destroy
    @food_item=@restaurant.food_items.find(params[:id])
    @food_item.destroy
    flash[:notice]="Food Items Deleted Successfully"
    redirect_to restaurant_food_items_path
   
  end


private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    # session['restaurant']=@restaurant
  end
 

  def food_item_params
    params.require(:food_item).permit(:name,  :price,:ingredients,:image)
  end
end
