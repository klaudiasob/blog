# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.float :area
      t.integer :floors
      t.integer :rooms
      t.integer :price
    end
  end
end
