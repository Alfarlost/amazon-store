class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 8, scale: 2
      t.datetime :completed_data
      t.string :state, default: "in progress"
      t.belongs_to :customer, index: true
      t.belongs_to :credit_card, index: true

      t.timestamps null: false
    end
  end
end
