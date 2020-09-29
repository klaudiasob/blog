# frozen_string_literal: true

class HouseDecorator < Draper::Decorator
  delegate_all

  def photo_url
    if object.photo.attached?
      h.url_for(object.photo)
    else
      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?cs=srgb&dl=pexels-binyamin-mellish-106399.jpg'
    end
  end

  def price_currency
    ActionController::Base.helpers.number_to_currency(object.price, unit: 'zł', format: '%n %u', separator: ',', delimiter: ' ')
  end

  def price_m2_currency
    price_for_m2 = object.price / object.area
    ActionController::Base.helpers.number_to_currency(price_for_m2, unit: 'zł', format: '%n %u', separator: ',', delimiter: ' ')
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
