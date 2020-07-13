class CreateImagesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :samples do |t|
      t.belongs_to :vendor

      t.string :title, :null => false, :default => "default"
      t.string :image, :null => false, :default => "https://i.ibb.co/VDvgFQs/download.png"
      t.string :medium, :null => false, :default => "https://i.ibb.co/VDvgFQs/download.png"
      t.string :thumb, :null => false, :default => "https://i.ibb.co/bLrs42k/download.png"
      t.string :delete, :null => false, :default => ""
      t.boolean :deleted, :null => false, default: false
      
    end
    
    create_table :logos do |t|
      t.belongs_to :meal

      t.string :title, :null => false, :default => "default"
      t.string :image, :null => false, :default => "https://i.ibb.co/rfN873y/247-2476490-food-vendor-icon-hd-png-download.png"
      t.string :medium, :null => false, :default => "https://i.ibb.co/rfN873y/247-2476490-food-vendor-icon-hd-png-download.png"
      t.string :thumb, :null => false, :default => "https://i.ibb.co/YTwnRXj/247-2476490-food-vendor-icon-hd-png-download.png"
      t.string :delete, :null => false, :default => ""
      t.boolean :deleted, :null => false, default: false
      
    end
  end
end
