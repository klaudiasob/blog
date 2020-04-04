# frozen_string_literal: true

class CreateCategoriesHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_houses do |t|
      t.integer :category_id
      t.integer :house_id
    end
  end
end
