class House < ApplicationRecord
  belongs_to :owner, optional: true
  has_one_attached :photo

  def price_for_m2
    price / area
  end
end
