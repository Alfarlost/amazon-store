class RemoveDefaultValueOfDeliveryColumnFromOrders < ActiveRecord::Migration
  def change
  	change_column_default :orders, :delivery, nil
  end
end
