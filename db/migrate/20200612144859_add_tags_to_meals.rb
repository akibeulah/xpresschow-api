class AddTagsToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :tag, :string, :null => false,:default => "featured"
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
