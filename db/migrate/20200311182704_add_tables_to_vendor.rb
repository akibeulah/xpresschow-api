class AddTablesToVendor < ActiveRecord::Migration[6.0]
  def change
    add_column :vendors, :reset_password_token, :string
    add_column :vendors, :reset_password_sent_at, :datetime
    add_column :vendors, :phone_number, :string
    add_column :vendors, :rating, :decimal, :precision => 3, :scale => 2

    add_column :users, :phone_number, :string
    add_column :users, :rating, :decimal, :precision => 3, :scale => 2
  end
end
