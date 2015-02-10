class CreateAddressesTable < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :state
      t.string :adress
      t.string :zipcode
      t.string :city
      t.string :phone
      t.string :country
      t.string :type
      t.boolean :same

      t.timestamps null: false
    end
  end
end
