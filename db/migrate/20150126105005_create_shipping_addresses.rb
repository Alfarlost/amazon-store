class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.belongs_to :order, index: true
      t.belongs_to :address, index: true

      t.timestamps null: false
    end
    add_foreign_key :shipping_addresses, :orders
    add_foreign_key :shipping_addresses, :addresses
  end
end
