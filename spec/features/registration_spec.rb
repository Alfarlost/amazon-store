require 'features/features_spec_helper'
include OauthStub
 
feature "Registration" do
  scenario "Visitor registers successfully via register form" do
    visit new_customer_registration_path
      fill_in 'Email', with: "alfar@gfht.com"
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button('Sign up')

    expect(page).not_to have_content 'Log In'
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'Settings'
    expect(page).to have_content 'Orders'
    expect(page).to have_content 'Books for sale'
    expect(page).to have_content I18n.t('devise.customers.customer.signed_up')
  end

  scenario "Visistor enters wrong data into register form" do
    FactoryGirl.create(:customer, email: "alfar@gfht.com")
    visit new_customer_registration_path
      fill_in 'Email', with: "alfar@gfht.com"
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: ''
      click_button('Sign up')
    
    expect(page).to have_content 'Log In'
    expect(page).not_to have_content 'Log Out'
    expect(page).not_to have_content 'Settings'
    expect(page).not_to have_content 'Orders'
    expect(page).not_to have_content 'Books for sale'
    expect(page).to have_content I18n.t('activerecord.errors.messages.taken')
    expect(page).to have_content I18n.t('activerecord.errors.messages.too_short', :count => 8)
    expect(page).to have_content I18n.t('activerecord.errors.messages.confirmation')
  end

  scenario "Visistor sign up with facebook" do
    visit new_customer_registration_path
      set_omniauth
      click_link 'Sign in with Facebook'
    
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'Settings'
    expect(page).to have_content 'Orders'
    expect(page).to have_content 'Books for sale'
  end 
end
