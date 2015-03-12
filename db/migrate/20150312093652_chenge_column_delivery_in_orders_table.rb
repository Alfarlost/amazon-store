class ChengeColumnDeliveryInOrdersTable < ActiveRecord::Migration
  def change
  	change_column_default :orders, :delivery, 10
  end
end
