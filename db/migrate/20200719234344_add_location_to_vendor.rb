class AddLocationToVendor < ActiveRecord::Migration[6.0]
  def change
    add_column :vendors, :location, :string
  end
end
