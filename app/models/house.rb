class House < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :owner, optional: false
  has_one_attached :photo

  def price_for_m2
    price / area
  end
end
