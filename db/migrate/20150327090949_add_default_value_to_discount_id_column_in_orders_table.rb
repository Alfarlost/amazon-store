class AddDefaultValueToDiscountIdColumnInOrdersTable < ActiveRecord::Migration
  def change
    change_column_default :orders, :discount_id, 1
  end
end
