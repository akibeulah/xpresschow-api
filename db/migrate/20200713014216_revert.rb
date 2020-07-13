class Revert < ActiveRecord::Migration[6.0]
  def change
    drop_table :samples
    drop_table :logos
    
    add_column :meals, :sample, :string, default: "https://i.ibb.co/VDvgFQs/download.png", null: false
    add_column :vendors, :logo, :string, default: "https://i.ibb.co/rfN873y/247-2476490-food-vendor-icon-hd-png-download.png", null: false
  end
end
