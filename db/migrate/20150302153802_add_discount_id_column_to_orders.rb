class AddDiscountIdColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :discount_id, :integer
  end
end
