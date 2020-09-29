require 'rails_helper'

RSpec.describe House, :type => :model do
  describe 'validations' do
    it { should validate_presence_of(:area) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:land_area) }
    it { should validate_presence_of(:interior_finishing) }
    it { should validate_presence_of(:available_from) }
    it { should validate_presence_of(:market) }
    it { should define_enum_for(:interior_finishing).with_values([:complete, :to_finish, :for_renovation]) }
    it { should define_enum_for(:market).with_values([:primary, :secondary]) }
  end

  describe 'associations' do
    it { should belong_to(:owner).class_name('Owner') }
    it { should have_and_belong_to_many(:categories).class_name('Category') }
  end
end