class AddPreparedToVendors < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :prepared, :boolean, :default => false, :null => :false
  end
end
