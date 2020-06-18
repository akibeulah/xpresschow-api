class AddAvailableToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :available, :boolean, :default => true, :null => false
    #Ex:- :default =>''
  end
end
