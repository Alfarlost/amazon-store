require 'features/features_spec_helper'

feature 'Shopping Cart' do
  scenario "Visitor see empty shopping cart on main page" do
    visit root_path
    expect(page).to have_content "empty"
  end

  context "with full shopping cart" do
    background do
      order = FactoryGirl.create(:order)
      FactoryGirl.create(:orderitem, order_id: order.id)
      ApplicationController.any_instance.stub(:current_order).and_return order
    end

    scenario "Visitor see full shopping cart on main page" do
      visit root_path
      expect(page).to have_content "$3.00"
    end

    scenario "Visitor see all content in shopping cart" do
      visit cart_path
      orderitem = Orderitem.first

      expect(page).to have_content orderitem.book.title
      expect(page).to have_content orderitem.book.description
      expect(page).to have_content orderitem.book.title
      expect(page).to have_field("orderitem_quantity", with: "2")
      expect(page).to have_field("order_coupone_code") 
      expect(page).to have_content orderitem.price
      expect(page).to have_content orderitem.unit_price
      expect(page).to have_button('Update Quantity')
      expect(page).to have_link('Delete')
      expect(page).to have_link('Check Out')
      expect(page).to have_link('Back to shop')
      expect(page).to have_button('UPDATE')
    end

    scenario "Vistor change book quantity" do
      visit cart_path
      orderitem = Orderitem.first
      @orderitem = orderitem
        fill_in "orderitem_quantity", :with => "5"
        click_button 'Update Quantity'
      
      expect(page).to have_content "$3.00"
      expect(page).to have_content "$15.00"
      expect(page).to have_content I18n.t('orderitems.book.updated')
      expect(page).to have_field("orderitem_quantity", with: "5")
    end
  end 
end
