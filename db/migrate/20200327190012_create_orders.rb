class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
        t.belongs_to :vendor, class_name: "vendor", foreign_key: "vendor_id"
        t.belongs_to :user, class_name: "user", foreign_key: "user_id"
        
        t.integer :servings, :null => false, :default => 1
        t.string :location
        t.string :payment_method
        t.boolean :paid, :default => false
        t.boolean :dispatched, :default => false
        t.boolean :delivered, :default => false
        
        t.timestamps
    end

    remove_column :users, :username
    add_column :meals, :sample_alt, :string
    add_column :meals, :discount, :integer
  end
end
