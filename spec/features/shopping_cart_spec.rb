require 'features/features_spec_helper'

feature 'Shopping Cart' do
  scenario "Visitor see empty shopping cart on main page" do
    visit root_path
    expect(page).to have_content "empty"
  end

  context "with full shopping cart" do
    given!(:discount) { FactoryGirl.create(:discount, id: 1) }
    given!(:order) { FactoryGirl.create(:order) }
    given!(:orderitem) { FactoryGirl.create(:orderitem, order_id: order.id) }
    given!(:orderitem_quantity) { 'order_orderitems_' + orderitem.id.to_s + '_quantity' }

    background do
      page.set_rack_session(:order_id => order.id)
    end

    scenario "Visitor see full shopping cart on main page" do
      page.visit root_path
      expect(page).to have_content "$3.00"
    end

    scenario "Visitor see all content in shopping cart" do
      page.visit cart_path

      expect(page).to have_content orderitem.book.title
      expect(page).to have_content orderitem.book.description
      expect(page).to have_content orderitem.book.title
      expect(page).to have_field(orderitem_quantity, with: "2")
      expect(page).to have_field("order_coupone_code") 
      expect(page).to have_content orderitem.price
      expect(page).to have_content orderitem.unit_price
      expect(page).to have_button('Update Orderitems Quantity')
      expect(page).to have_link('Delete')
      expect(page).to have_link('Check Out')
      expect(page).to have_link('Back to shop')
      expect(page).to have_button('GET DISCOUNT')
    end

    scenario "Vistor change book quantity" do
      page.visit cart_path
        fill_in orderitem_quantity, :with => 5
        click_button 'Update Orderitems Quantity'
      
      expect(page).to have_content "$3.00"
      expect(page).to have_content "#{orderitem.unit_price*5}"
      expect(page).to have_content I18n.t('orderitems.book.updated')
      expect(page).to have_field(orderitem_quantity, with: "5")
    end

    scenario "Vistor enter right coupone code" do
        page.visit cart_path
          fill_in 'Coupone Code', :with => "DISK"
          click_button 'GET DISCOUNT'

        expect(page).to have_content(order.recalculate_total_price - order.recalculate_total_price*0.05)
        expect(page).to have_content I18n.t('order.coupone_code.right')
    end
    
    context 'when discount present' do
      given!(:order_with_used_coupone_code) {FactoryGirl.create(:order_with_orderitem, coupone_code: 'DISK')}

      scenario "Vistor enter the same coupone code again" do
        page.set_rack_session(:order_id => order_with_used_coupone_code.id)
        page.visit cart_path
          fill_in 'Coupone Code', :with => "DISK"
          click_button 'GET DISCOUNT'
        
        expect(page).to have_content order.recalculate_total_price
        expect(page).to have_content I18n.t('order.coupone_code.used')
      end
    end

    scenario "Vistor enter wrong coupone code" do
      page.visit cart_path
        fill_in 'Coupone Code', :with => "UNVA"
        click_button 'GET DISCOUNT'
      
      expect(page).to have_content order.recalculate_total_price
      expect(page).to have_content I18n.t('order.coupone_code.unavailable')
    end

    scenario "Visitor clear shopping cart" do
        page.visit cart_path
        click_link "Delete"

      expect(page).to have_content "There are no items in your shopping cart. Please go back and choose"
      expect(page).to have_content I18n.t('orderitems.book.removed')
    end

    scenario "Visitor press checkout button" do
      page.visit cart_path
        click_link "Check Out"

      expect(page).to have_content "BILLING ADDRESS"
      expect(page).to have_content "#{order.total_price}"
      expect(page).to have_button "SAVE AND CONTINUE"
    end
  end 
end
