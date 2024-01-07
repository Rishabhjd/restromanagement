# frozen_string_literal: true
class Ability
include CanCan::Ability

def initialize(user)
  user ||= User.new
 
  can :read, Restaurant, user: user
  case user.role.to_sym
  when :superadmin
    can :manage, :all
    can :read,User
    can :edit,User,id: user.id
  when :owner
  
    can :manage , FoodItem,user_id:user.id
    can :read,Order
    can :read,Restaurant,user_id:user.id
    
     can :accept,Order
     when :member
    can :read, :all
    can :create,Order
    # Add more abilities for member role if needed
  else
    
    can :read, :all

  end
  
end
end