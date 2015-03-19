require 'features/features_spec_helper'
include OauthStub
 
feature "Sign In" do
  background do
    FactoryGirl.create(:customer, email: "alfar@gfht.com")
  end

  scenario "Visitor sign in successfully via sign_in form" do
    visit new_customer_session_path
      fill_in 'Email', with: "alfar@gfht.com"
      fill_in 'Password', with: 'zaqwer12'
      click_button('Log in')

    expect(page).not_to have_content 'Log In'
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'Settings'
    expect(page).to have_content 'Orders'
    expect(page).to have_content 'Books for sale'
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  scenario "Visistor try to sign in with wrong data via sign in form" do
    visit new_customer_session_path
      fill_in 'Email', with: "123@gfht.com"
      fill_in 'Password', with: '123'
      click_button('Log in')
    
    expect(page).to have_content 'Log In'
    expect(page).not_to have_content 'Log Out'
    expect(page).not_to have_content 'Settings'
    expect(page).not_to have_content 'Orders'
    expect(page).not_to have_content 'Books for sale'
    expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: 'email')
  end

  scenario "Visistor sign in with facebook" do
    visit new_customer_session_path
      set_omniauth(:info => {:email => "alfar@gfht.com"})
      click_link 'Sign in with Facebook'
    
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'Settings'
    expect(page).to have_content 'Orders'
    expect(page).to have_content 'Books for sale'
  end 
end