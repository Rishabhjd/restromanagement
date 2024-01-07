require 'rails_helper'

RSpec.describe FoodItem, type: :model do
  it { should have_many(:line_items).dependent(:destroy) }
  it { should have_many(:carts).through(:line_items) }
  describe '#image' do
  subject { Restaurant.create.image }

  it { is_expected.to be_an_instance_of(ActiveStorage::Attached::One) }
end
it { should validate_presence_of(:name) }
it { should validate_presence_of(:price) }
it { should validate_presence_of(:ingredients) }
it { should belong_to(:restaurant) }
it { should validate_numericality_of(:price).is_greater_than(0)}
end
