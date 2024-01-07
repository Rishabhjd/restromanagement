class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_and_belongs_to_many :restaurants,join_table: "restaurants_users"
         has_many :orders

         enum role: %i[superadmin owner member]
         after_initialize :set_default_role, if: :new_record?
         # set default role to user  if not set
         def set_default_role
           self.role ||= :user
         end
         validates :email, presence: true, uniqueness: true
         validates :encrypted_password, presence: true
         validates :firstname, presence: true
         validates :lastname, presence: true
         validates :address, presence: true
         validates :contactno, presence: true
         validates_format_of :contactno,with:/\d{10}\)*\z/, :message => "Enter a valid contactno"
       
end
