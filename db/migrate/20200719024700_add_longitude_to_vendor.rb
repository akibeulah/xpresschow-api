class AddLongitudeToVendor < ActiveRecord::Migration[6.0]
  def change
    add_column :vendors, :latitude, :float
    add_column :vendors, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
