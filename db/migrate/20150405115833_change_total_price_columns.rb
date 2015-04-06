class ChangeTotalPriceColumns < ActiveRecord::Migration
  def change
    change_column :orders, :total_prize_without_discount, :decimal, :precision => 8, :scale => 2
    change_column :orders, :total_prize_with_discount,  :decimal, :precision => 8, :scale => 2
    rename_column :orders, :total_prize_without_discount, :total_price_without_discount
    rename_column :orders, :total_prize_with_discount, :total_price_with_discount
  end
end
