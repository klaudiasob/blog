# frozen_string_literal: true

module HouseServices
  class Update
    attr_reader :house, :params, :categories

    def initialize(house, params)
      @house = house
      @params = params.except(:categories)
      @categories = params[:categories]
    end

    def call
      house.assign_attributes(params)
      assign_categories
      house.save
    end

    def assign_categories
      return unless categories

      new_categories = Category.where(id: categories.drop(1))
      house.assign_attributes({ categories: new_categories })
    end
  end
end
