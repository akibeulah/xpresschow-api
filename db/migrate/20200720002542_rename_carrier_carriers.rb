class RenameCarrierCarriers < ActiveRecord::Migration[6.0]
  def change
    rename_table :carrier, :carriers

    add_column :carriers, :phone_number, :string
  end
end
