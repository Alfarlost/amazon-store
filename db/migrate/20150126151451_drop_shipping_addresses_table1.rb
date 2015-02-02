class DropShippingAddressesTable1 < ActiveRecord::Migration
  def change
  	drop_table :shipping_addresses
  end
end
