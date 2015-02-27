require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  let(:category) { FactoryGirl.create(:category) }
  describe "GET index" do
    it "assigns @categories" do
      category1 = FactoryGirl.create(:category)
      get :index
      expect(assigns(:categories)).to eq [category1, category]
    end

    it "renders index page" do
      get :index
      expect(response).to render_template "index"
    end
  end

  describe "GET show" do
    it "assigns @category" do
      Category.stub(:find).and_return category
      get :show, id: category.id
      expect(assigns(:category)).to eq category
    end

    it "assigns @books" do
      book1 = FactoryGirl.create(:book, category_id: category.id)
      book2 = FactoryGirl.create(:book, category_id: category.id)
      Category.stub(:find).and_return category
      get :show, id: category.id
      expect(assigns(:books)).to eq [book1, book2]
    end

    it "renders show page" do
      get :show, id: category.id
      expect(response).to render_template "show"
    end
  end
end
