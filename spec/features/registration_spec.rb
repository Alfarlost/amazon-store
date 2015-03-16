require 'features/features_spec_helper'
 
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
    expect(page).to have_content 'Categories'
    expect(page).to have_content I18n.t('devise.customers.customer.signed_up')
  end
end
