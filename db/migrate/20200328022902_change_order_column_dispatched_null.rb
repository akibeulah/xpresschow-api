class ChangeOrderColumnDispatchedNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :orders, :paid, false
    change_column_null :orders, :dispatched, false
    change_column_null :orders, :delivered, false
  end
end
