class House < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :owner, optional: false
  has_one_attached :photo

  validates :area, :price, :description, :land_area, :interior_finishing, :available_from, :market, presence: true

  enum interior_finishing: [:complete, :to_finish, :for_renovation]
  enum market: [:primary, :secondary]

  def price_for_m2
    price / area
  end
end
