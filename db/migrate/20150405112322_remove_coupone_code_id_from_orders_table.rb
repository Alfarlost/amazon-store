class RemoveCouponeCodeIdFromOrdersTable < ActiveRecord::Migration
  def up
    remove_column :orders, :discount_id
    add_column :orders, :total_prize_without_discount, :integer
    add_column :orders, :total_prize_with_discount, :integer
  end

  def down
    add_column :orders, :discount_id, :integer
    remove_column :orders, :total_prize_without_discount
    remove_column :orders, :total_prize_with_discount
  end
end
