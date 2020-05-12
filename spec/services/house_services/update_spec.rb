# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HouseServices::Update do
  subject(:update_house) { described_class.new(house, params).call }

  let(:house) { create(:house) }

  describe '.call' do
    context 'when params include house attributes' do
      let(:params) do
        {
          'area' => 56,
          'land_area' => 15
        }
      end

      it 'updates the house' do
        update_house

        expect(house.attributes).to match(hash_including(params))
      end
    end

    context 'when categories are present in params' do
      let(:category) { create(:category) }
      let(:params) do
        {
          categories: ['', category.id.to_s]
        }
      end

      it 'assignes category to house' do
        update_house

        expect(house.categories).to include category
      end

      context 'when house has two categories' do
        let(:house) { create(:house, :with_two_categories) }
        let(:category) { create(:category) }
        let(:params) do
          {
            categories: ['', category.id.to_s]
          }
        end

        it 'assigns one category to house' do
          update_house

          expect(house.categories).to include category
        end
      end
    end
  end
end
