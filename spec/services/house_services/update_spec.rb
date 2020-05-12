require 'rails_helper'

RSpec.describe HouseServices::Update do
  subject(:update_house) { described_class.new(house, params).call }

  let(:house) { create(:house) }

  describe '.call' do
    context 'when params include house attributes' do
      let(:params) {
        {
            area: 56,
            land_area: 15
        }
      }

      it 'updates the house' do
        update_house

        expect(house.area).to eq 56
        expect(house.land_area).to eq 15
      end
    end

    context 'when categories are present in params' do
      let(:category) { create(:category) }
      let(:params) {
        {
            categories: ['', category.id.to_s]
        }
      }

      it 'assignes category to house' do
        update_house

        expect(house.categories).to include category
      end

      context 'when house has two categories' do
        let(:house) { create(:house, :with_two_categories) }
        let(:category) { create(:category) }
        let(:params) {
          {
              categories: ['', category.id.to_s]
          }
        }

        it 'assignes one category to house' do
          update_house

          expect(house.categories).to include category
        end
      end
    end
  end
end