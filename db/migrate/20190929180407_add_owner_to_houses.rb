# frozen_string_literal: true

class AddOwnerToHouses < ActiveRecord::Migration[5.2]
  def change
    add_reference :houses, :owner, foreign_key: true
  end
end
