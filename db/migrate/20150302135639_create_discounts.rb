class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :coupone_code
      t.float :discount
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
