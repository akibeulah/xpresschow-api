class DeleteVendornameFromVendors < ActiveRecord::Migration[6.0]
  def change
    remove_column :meals, :vendorname
  end
end
