class ChangePriceColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :houses, :price, :float
  end
end
