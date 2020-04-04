# frozen_string_literal: true

class AddPhoneNumberToOwners < ActiveRecord::Migration[5.2]
  def change
    add_column :owners, :phone_number, :float
  end
end
