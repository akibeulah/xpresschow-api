class AddViableToCarrier < ActiveRecord::Migration[6.0]
  def change
    add_column :carrier, :viable, :boolean, :default => true, :null => false
    add_column :vendors, :viable, :boolean, :default => true, :null => false
    add_column :users, :viable, :boolean, :default => true, :null => false
    add_column :meals, :viable, :boolean, :default => true, :null => false
  end
end