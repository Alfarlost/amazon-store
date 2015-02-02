class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.belongs_to :order, index: true
      t.belongs_to :address, index: true

      t.timestamps null: false
    end
    add_foreign_key :billing_addresses, :orders
    add_foreign_key :billing_addresses, :addresses
  end
end
