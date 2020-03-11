class CreateVendors < ActiveRecord::Migration[6.0]
  def change
    create_table :vendors do |t|
      t.string :vendorname
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
