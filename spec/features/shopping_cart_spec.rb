require 'features/features_spec_helper'

feature 'Shopping Cart' do 
  scenario "Visitor see empty shopping cart on main page" do
    visit root_path
    expect(page).to have_content "CART: ( 0 )"
  end

  scenario "Visitor see full shopping cart on main page" do
    background do
      order = Order.create
      4.times { Orderitem.create(price: 10, quntity: 10, order_id: order.id) }
    end

    visit root_path
    expect(page).to have_content "CART: ( 4 )"
  end 
end
