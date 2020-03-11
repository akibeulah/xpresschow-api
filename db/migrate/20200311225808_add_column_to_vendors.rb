class AddColumnToVendors < ActiveRecord::Migration[6.0]
  def change
    add_column :vendors, :company_name, :string
    add_column :vendors, :company_branch, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
