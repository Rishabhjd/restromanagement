class RestaurantsController < ApplicationController
  before_action :restaurant_id,only: %i[show edit update destroy]
  load_and_authorize_resource

  def new
    @restaurant=Restaurant.new
    # authorize! :create, @restaurant
    
  end

  def create
    @restaurant=Restaurant.new(restaurant_params)
   
    if @restaurant.save
      @restaurant.users<<User.find(restaurant_params[:user_id])
      redirect_to @restaurant
    else
      render :new
    end
  end
  
  def index 
    @restaurants = Restaurant.page(params[:page]).per(10)
    if user_signed_in?

      if current_user.owner?
      @restaurants= current_user.restaurants
      
      else
        @restaurants=Restaurant.all  
    end
  end
 
   
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    # @food_items = @restaurant.food_items
  end

  def edit
   
  end

  def update
  
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant
    else
      render :edit
    end
  end

  def landing
    redirect_to(action: :home,
                params: request.query_parameters) if user_signed_in?
  end

  def home
    redirect_to(action: :landing,
                params: request.query_parameters) unless user_signed_in?
  end
  def destroy
    @restaurant.destroy
    redirect_to root_path
   
  end


private

def restaurant_id
  @restaurant=Restaurant.find(params[:id])
end
def restaurant_params
params.require(:restaurant).permit(:name,:location,:image,:owner_name,:user_id)
end

end
