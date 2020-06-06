class AddPriceToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :price, :decimal, :precision => 10, :scale => 2

    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
