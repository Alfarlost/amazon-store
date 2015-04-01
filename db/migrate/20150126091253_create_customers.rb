class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :password
      t.string :firstname
      t.string :lastname

      t.timestamps null: false
    end
  end
end
