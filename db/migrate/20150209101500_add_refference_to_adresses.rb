class AddRefferenceToAdresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :customer, index: true
    add_reference :addresses, :order, index: true
  end
end
