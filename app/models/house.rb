# frozen_string_literal: true

class House < ApplicationRecord
  acts_as_paranoid
  has_and_belongs_to_many :categories
  belongs_to :owner, optional: false
  has_one_attached :photo
  paginates_per 6

  validates :area, :price, :description, :land_area, :interior_finishing, :available_from, :market, presence: true

  enum interior_finishing: %i[complete to_finish for_renovation]
  enum market: %i[primary secondary]

  def price_for_m2
    price / area
  end
end
