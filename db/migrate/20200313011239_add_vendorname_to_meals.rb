class AddVendornameToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :vendorname, :string
  end
end
