require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:contactno) }
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:encrypted_password) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should have_and_belong_to_many(:restaurants) }
  it{should User.new.set_default_role.eql?(:user)   }
  let(:user) {
   User.create(
     firstname: "Ram",
     lastname:"Singh",
     address:"indore",
     contactno:9087654367,
     role:"member",
     encrypted_password:123465

   )
  }

  it "has many orders" do
    first_order = Order.create(address: "Discourses")
    second_order = Order.create(address: "Enchiridion")
    user.orders << [first_order, second_order]
    expect(user.orders.first).to eq(first_order)   
    expect(user.orders.second).to eq(second_order)
   end
  end


