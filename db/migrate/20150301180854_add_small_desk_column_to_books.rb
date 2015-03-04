class AddSmallDeskColumnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :small_description, :text
  end
end
