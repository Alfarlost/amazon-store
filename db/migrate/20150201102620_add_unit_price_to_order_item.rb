class AddUnitPriceToOrderItem < ActiveRecord::Migration
  def change
    add_column :orderitems, :unit_price, :decimal, precision: 8, scale: 2
  end
end
