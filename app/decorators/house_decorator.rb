class HouseDecorator < Draper::Decorator
  delegate_all

  def photo_url
    if object.photo.attached?
      url_for(object.photo)
    else
      "https://assets.archon.pl/images/products/mfe42422780eaf/widok-1-projekt-dom-w-balsamowcach-2-1565787666__289.jpg"
    end
  end



  def price_currency
    ActionController::Base.helpers.number_to_currency(object.price, unit: 'zł', format: '%n %u', separator: ',', delimiter: ' ')
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end

end