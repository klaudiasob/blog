# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HouseDecorator, type: :decorator do
  let(:house) { create(:house, price: 500_000.50, area: 100).decorate }

  describe 'price currency' do
    it 'sets the currency and format of the house price' do
      price = house.price_currency
      expect(price).to eq('500 000,50 zł')
    end
  end

  describe 'price for m2' do
    it 'set the currency and format of the price for m2' do
      price_m2 = house.price_m2_currency
      expect(price_m2).to eq('5 000,01 zł')
    end
  end
end
