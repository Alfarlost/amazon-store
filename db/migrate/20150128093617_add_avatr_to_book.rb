class AddAvatrToBook < ActiveRecord::Migration
  def change
    add_column :books, :avatar, :string
  end
end
