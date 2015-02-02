class RemoveEmailColumnFromCustomersTable < ActiveRecord::Migration
  def change
  	remove_column :customers, :email
  	remove_column :admins, :email
  end
end
