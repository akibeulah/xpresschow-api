class CreateTableAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :address
      t.float :longitude
      t.float :latitude
      t.timestamps

      t.belongs_to :user 
    end
  end
end
