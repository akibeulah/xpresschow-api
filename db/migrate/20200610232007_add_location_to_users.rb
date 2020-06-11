class AddLocationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :location, :string
    add_column :vendors, :location, :string, :null => false, :default => "Abuja"
    add_column :vendors, :address, :string, :null => false, :default => ""
  end
end
