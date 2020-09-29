class RemovePhoneNumberFormOwners < ActiveRecord::Migration[5.2]
  def change
    remove_column :owners, :phone_number
  end
end
