class AddReferenceToCreditCards < ActiveRecord::Migration
  def change
    add_reference :credit_cards, :order, index: true
  end
end
