Rails.application.routes.draw do
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce'=>"line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  post 'line_items/:id/remove'=>"line_items#remove",as: "line_item_remove"
  # resources :line_items do
  #   delete :remove, on: :member
  # end
  # get 'carts/show'
  resource :cart, only: [:show, :destroy]
resources :line_items
   get '/orders',to: "orders#index"
  # get 'orders/index'
  # get 'orders/show'
  # get 'orders/edit'
  # get 'food_items/new'
  # get 'food_items/index'
 resources :restaurants do
  resources :orders do
    member do 
      post 'accept'
    end
  end
  
   resources :food_items do
   
  member do
    post 'increment_quantity'
    post 'decrement_quantity'
  end
 end
end
resources :orders,only:[:new,:create,:show]

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

root  "restaurants#index"
scope '/superadmin' do
  resources :users
end
  # Defines the root path route ("/")
  # root "posts#index"
end
