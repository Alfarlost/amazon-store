class ChangeOrdersStateDefaultValue < ActiveRecord::Migration
  def change
  	change_column_default :orders, :state, "empty"
  end
end
