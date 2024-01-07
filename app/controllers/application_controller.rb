class ApplicationController < ActionController::Base
    before_action :current_cart
    
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    rescue_from CanCan::AccessDenied do |exception|
        exception.default_message = "You are not authorized to perform this task"
        respond_to do |format|
          format.json { head :forbidden }
          format.html { redirect_to root_path, alert: exception.message }
        end
      end

      

    protected
     def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:role,:email, :password,:password_confirmation,  :firstname, :lastname ,:address,:contactno) }
       devise_parameter_sanitizer.permit(:account_update) { |u|    u.permit(:role,:email, :password,:password_confirmation,  :firstname, :lastname ,:address,:contactno) }
     end
     private 
     def current_cart
         if session[:cart_id]
             cart =Cart.find_by(:id=>session[:cart_id])
             if cart.present?
             @current_cart=cart
             else
             session[:cart_id]=nil
             end
         end
         
         if session[:cart_id]== nil
         
         @current_cart=Cart.create
         session[:cart_id]=@current_cart.id
         end
     end
    
end