require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:line_items) }
    it { should have_many(:restaurants).through(:line_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with(%i[pending placed]) }
  end
end
