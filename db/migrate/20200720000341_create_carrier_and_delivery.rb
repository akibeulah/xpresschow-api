class CreateCarrierAndDelivery < ActiveRecord::Migration[6.0]
  def change
    create_table :carrier do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :vehicle_type
      t.integer :delivery_count

      t.timestamps
    end
    
    create_table :deliveries do |t|
      t.belongs_to :orders
      t.belongs_to :carrier
      
      t.timestamps
    end
  end
end
