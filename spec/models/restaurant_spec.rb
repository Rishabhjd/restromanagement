require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it { should have_many(:food_items).dependent(:destroy) }
  it { should have_and_belong_to_many(:users).join_table('restaurants_users') }
  it { should have_many(:line_items) }
  it { should have_many(:orders).through(:line_items) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:owner_name) }
 
  describe '#image' do
  subject { Restaurant.create.image }

  it { is_expected.to be_an_instance_of(ActiveStorage::Attached::One) }
end
 

  


end
