require 'features/features_spec_helper'
 
feature "Registration" do
  scenario "Visitor registers successfully via register form" do
    visit register_path
    within '#new_user' do
      fill_in 'Name', with: 'test'
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '12345678'
      click_button('Sign up')
    end
    expect(page).not_to have_content 'Sign up'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'You registered'
  end
end
