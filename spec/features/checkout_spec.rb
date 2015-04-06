require 'features/features_spec_helper'

feature "Checkout" do
  given!(:order) { FactoryGirl.create(:order_with_orderitem) }

    background do
      page.set_rack_session(:order_id => order.id) 
    end

  context "adresses step" do
    context "visitor without sign in" do
      before do
        page.visit checkout_path(Checkout.form_steps.first)
          fill_in 'checkout_b_first_name', with: "John"
          fill_in 'checkout_b_last_name', with: "Doe"
          fill_in 'checkout_b_adress', with: "5 north-east"
          fill_in 'checkout_b_city', with: "heaven"
          fill_in 'checkout_b_country', with: "USA"
          fill_in 'checkout_b_zipcode', with: 32454
          fill_in 'checkout_b_city', with: "Paris"
      end

      context "passed" do
        after do
          expect(page).to have_field("checkout_delivery_5", with: 5)
          expect(page).to have_field("checkout_delivery_10", with: 10)
          expect(page).to have_field("checkout_delivery_15", with: 15)
          expect(page).to have_content "Order Total: $#{order.total_price}0"
        end           
  
        scenario "Visitor passed adresses step sucessfuly with checked checkbox" do
            fill_in 'checkout_b_phone', with: "+380675434567"
            check 'checkout_same_shipping_address'
            click_button 'SAVE AND CONTINUE'
        end

        scenario "Visitor passed adresses step sucessfuly with unchecked checkbox" do
          fill_in 'checkout_b_phone', with: "+380675434567"
          fill_in 'checkout_s_first_name', with: "John"
          fill_in 'checkout_s_last_name', with: "Doe"
          fill_in 'checkout_s_adress', with: "5 north-east"
          fill_in 'checkout_s_city', with: "heaven"
          fill_in 'checkout_s_country', with: "USA"
          fill_in 'checkout_s_zipcode', with: 32454
          fill_in 'checkout_s_city', with: "Paris"
          fill_in 'checkout_s_phone', with: "+380675434567"
          click_button 'SAVE AND CONTINUE'
        end
      end 
      context "failed" do
        after do
          expect(page).not_to have_field("checkout_delivery_5", with: 5)
          expect(page).to have_field('checkout_s_first_name', with: "")
          expect(page).to have_content "Order Total: $#{order.total_price}0"
          expect(page).to have_content I18n.t('checkout.errors.missing_data')
        end

        scenario "Visitor failed to pass adresses step with unchecked checkbox" do
          page.visit checkout_path(Checkout.form_steps.first)
            fill_in 'checkout_b_phone', with: "+380675434567"
            click_button 'SAVE AND CONTINUE'
        end
        scenario "Visitor failed to pass adresses step when forgot to enter some information" do
          page.visit checkout_path(Checkout.form_steps.first)
            check 'checkout_same_shipping_address'
            click_button 'SAVE AND CONTINUE'
        end     
      end
    end
    context 'loged in customer' do
      given!(:customer) { FactoryGirl.create(:customer) }
      given!(:order1) { FactoryGirl.create(:order_with_orderitem, customer: customer) }

      background do
        page.visit new_customer_session_path
          fill_in 'Email', with: customer.email
          fill_in 'Password', with: customer.password
          click_button('Log in')
        page.set_rack_session(:order_id => order1.id)
        page.visit checkout_path(Checkout.form_steps.first)
      end
      
      scenario "Visitor with full account information passed adresses step sucessfuly without entering data" do  
          click_button 'SAVE AND CONTINUE'
  
        expect(page).to have_field("checkout_delivery_5", with: 5)
        expect(page).to have_field("checkout_delivery_10", with: 10)
        expect(page).to have_field("checkout_delivery_15", with: 15)
        expect(page).to have_content "Order Total: $#{order1.total_price}0"      
      end

      scenario "Visitor with full account information failled to pass adresses step when deleted some information" do
          fill_in 'checkout_b_phone', with: ""
          click_button 'SAVE AND CONTINUE'

        expect(page).not_to have_field("checkout_delivery_5", with: 5)
        expect(page).to have_field('checkout_b_phone', with: "")
        expect(page).to have_content I18n.t('checkout.errors.missing_data')
        expect(page).to have_content "Order Total: $#{order1.total_price}0"
      end
    end
  end
  
  context "with passed adresses step" do
    given!(:billing_address) { FactoryGirl.create(:billing_address, order_id: order.id) }
    given!(:shipping_address) { FactoryGirl.create(:shipping_address, order_id: order.id) }

    scenario "Visitor pass delivery step sucessfuly" do
      page.visit checkout_path(Checkout.form_steps[1])
        choose 'checkout_delivery_10'
        click_button 'SAVE AND CONTINUE'

      expect(page).not_to have_field("checkout_delivery_5", with: 5)
      expect(page).to have_field("checkout_number")
      expect(page).to have_field("checkout_cvv")
      expect(page).to have_field("checkout_expiration_month")
      expect(page).to have_field("checkout_expiration_year")
      expect(page).to have_content "Delivery: $10.00"
    end

    context "with passed delivery step" do
      before do
        page.visit checkout_path(Checkout.form_steps[2])
          fill_in "checkout_number", with: "1234567891234567"
          select 12, :from => "checkout_expiration_month"
          select 2017, :from =>"checkout_expiration_year"
      end

      scenario "Visitor passed payment step sucessfuly" do
          fill_in "checkout_cvv", with: "987"
          click_button 'SAVE AND CONTINUE'

        expect(page).not_to have_field("checkout_cvv")
        expect(page).to have_content billing_address.adress
        expect(page).to have_content billing_address.city 
        expect(page).to have_content billing_address.zipcode
        expect(page).to have_content billing_address.country
        expect(page).to have_content billing_address.phone
        expect(page).to have_content shipping_address.adress
        expect(page).to have_content shipping_address.city 
        expect(page).to have_content shipping_address.zipcode
        expect(page).to have_content shipping_address.country
        expect(page).to have_content shipping_address.phone
        expect(page).to have_content "UPS One Day + $10.00"
        expect(page).to have_content "************567"
        expect(page).to have_content "12/2017"
        expect(page).to have_content "BOOK"
        expect(page).to have_content "QTY"
      end

      scenario "Visitor failed to pass payment step sucessfuly" do
        click_button 'SAVE AND CONTINUE'

        expect(page).to have_field("checkout_cvv")
        expect(page).not_to have_content billing_address.adress
        expect(page).not_to have_content "************567"
      end

      context "edit checkout information and finish" do
        given!(:credit_card) {FactoryGirl.create(:credit_card, order_id: order.id) }

        context "edit" do
          after do 
            expect(page).to have_content "BOOK"
            expect(page).to have_content "QTY"
          end            
          scenario "Visitor updated billing address sucessfuly" do
            page.visit checkout_path(Checkout.form_steps[0])
              fill_in 'checkout_b_zipcode', with: 11111
              click_button 'SAVE AND CONTINUE'

            expect(page).to have_content "11111"
            expect(page).to have_content "************567"
          end

          scenario "Visitor updated delivery sucessfuly" do
            page.visit checkout_path(Checkout.form_steps[1])
              choose 'checkout_delivery_5'
              click_button 'SAVE AND CONTINUE'
  
            expect(page).to have_content billing_address.zipcode
            expect(page).to have_content "UPS Ground + $5.00"
          end
  
          scenario "Visitor updated credit card information sucessfuly" do
            page.visit checkout_path(Checkout.form_steps[2])
              select 2020, :from =>"checkout_expiration_year"
              click_button 'SAVE AND CONTINUE'

            expect(page).to have_content "1/2020"
            expect(page).to have_content "UPS One Day + $10.00"
          end
        end
        
        scenario "Visitor finished checkout sucessfuly" do
          page.visit checkout_path(Checkout.form_steps[3])
            click_link 'PLACE ORDER'

          expect(page).to have_content I18n.t('order.state.in_queue')
          expect(page).to have_content "empty"
        end
      end  
    end
  end
end
