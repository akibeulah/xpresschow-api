class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.belongs_to :vendor, class_name: "vendor", foreign_key: "vendor_id"
      
      t.string :name
      t.string :desc
      t.decimal :rating, :precision => 3, :scale => 2
      
      t.timestamps
    end
  end
end
