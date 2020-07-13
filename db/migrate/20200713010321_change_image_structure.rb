class ChangeImageStructure < ActiveRecord::Migration[6.0]
  def change
    remove_column :vendors, :logo, :string
    remove_column :meals, :sample, :string
  end
end
