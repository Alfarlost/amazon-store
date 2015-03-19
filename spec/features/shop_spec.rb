require 'features/features_spec_helper'

feature "Shop" do
  given!(:category) {FactoryGirl.create(:category_list)}
  given!(:category1) {FactoryGirl.create(:category_list)}
  
  scenario "Visitor chose second book and want to see details" do
    visit categories_path
      within all('.input-group-btn')[1] do
        click_link "See Details"
      end

      expect(page).to have_content category.books.second.title
      expect(page).to have_button "Add to Cart"
      expect(page).to have_content "Reviews: (Add new Review)"
  end
  scenario "Visitor chose second book and want see details" do
  end 

end