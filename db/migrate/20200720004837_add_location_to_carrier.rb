class AddLocationToCarrier < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :location, :string
    add_column :users, :location, :string
    add_column :orders, :address, :string
  end
end
