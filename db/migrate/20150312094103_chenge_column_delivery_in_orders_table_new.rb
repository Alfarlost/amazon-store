class ChengeColumnDeliveryInOrdersTableNew < ActiveRecord::Migration
  def change
  	change_column_default :orders, :delivery, 0
  end
end
