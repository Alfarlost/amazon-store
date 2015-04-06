class ChangeDefaultValueOfStateColumnInOrdersTable < ActiveRecord::Migration
  def change
    change_column_default :orders, :state, "in progress"
  end
end
