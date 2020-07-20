class FixNamingConventionForLocationInUserAndVendor < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :location, :address
    remove_column :vendors, :location
  end
end