class AddAddressToCarrier < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :address, :string
  end
end
