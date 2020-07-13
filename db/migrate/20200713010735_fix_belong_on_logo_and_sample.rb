class FixBelongOnLogoAndSample < ActiveRecord::Migration[6.0]
  def change
    remove_column :logos, :meal_id
    remove_column :samples, :vendor_id

    add_reference :logos, :vendor, index: true
    add_reference :samples, :meals, index: true
  end
end
