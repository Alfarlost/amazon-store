class AddAasmStateColumnToRatingsTable < ActiveRecord::Migration
  def change
    add_column :ratings, :aasm_state, :string
  end
end
