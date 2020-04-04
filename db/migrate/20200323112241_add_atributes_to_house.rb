# frozen_string_literal: true

class AddAtributesToHouse < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :description, :string, allow_nil: false
    add_column :houses, :land_area, :float, allow_nil: false
    add_column :houses, :construction_year, :integer
    add_column :houses, :interior_finishing, :integer, allow_nil: false
    add_column :houses, :available_from, :date, allow_nil: false
    add_column :houses, :market, :integer, allow_nil: false
    add_column :houses, :rent, :float
    add_column :houses, :media, :string
    add_column :houses, :additional_info, :string
  end
end
