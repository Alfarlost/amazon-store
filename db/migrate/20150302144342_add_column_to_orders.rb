class AddColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :coupone_code, :string
  end
end
