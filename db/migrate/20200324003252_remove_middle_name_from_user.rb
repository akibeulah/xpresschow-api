class RemoveMiddleNameFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :middle_name
  end
end
