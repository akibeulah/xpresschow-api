class AddIndexVendir < ActiveRecord::Migration[6.0]
  def change
    add_index :vendors, [:company_name, :company_branch], :unique => true
    #Ex:- add_index("admin_users", "username")
  end
end
