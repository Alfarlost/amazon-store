class AddTypeColumnToAddressesTAble < ActiveRecord::Migration
  def change
  	add_column :addresses, :type, :string
  end
end
