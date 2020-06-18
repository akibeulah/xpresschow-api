class AddTrackingToOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :meal_id
    remove_column :orders, :servings

    create_table :order_records do |t|
      t.integer :meal_id
      t.integer :servings, :null => false, :default => 1
      
      t.belongs_to :order
    end
    
  end
end
