class CreateOrderitems < ActiveRecord::Migration
  def change
    create_table :orderitems do |t|
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity
      t.belongs_to :order, index: true
      t.belongs_to :book, index: true

      t.timestamps null: false
    end
  end
end
