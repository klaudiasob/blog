class AddAdminToOwners < ActiveRecord::Migration[5.2]
  def change
    add_column :owners, :admin, :boolean, default: false
  end
end
