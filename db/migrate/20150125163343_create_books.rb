class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.integer :bookinstock
      t.belongs_to :author, index: true
      t.belongs_to :category, index: true


      t.timestamps null: false
    end
  end
end
