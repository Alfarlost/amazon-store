require 'rails_helper'

RSpec.describe BooksController, :type => :controller do
  describe "GET #index" do
    it "assigns @books" do
      FactoryGirl.create(:orderitem)
      get :index
      expect(assigns(:books)).not_to be_empty
    end

    it "renders index page" do
      get :index
      expect(response).to render_template "index"
    end
  end

  describe "GET #show" do
    let(:book) { FactoryGirl.create(:book) }
    it "assigns @book" do
      Book.stub(:find).and_return book
      get :show, id: book.id
      expect(assigns(:book)).to eq book
    end

    it "assigns @orderitem" do
      order = FactoryGirl.create(:order)
      controller.stub(:current_order).and_return order
      get :show, id: book.id
      expect(assigns(:orderitem)).to be_a_new(Orderitem)
    end

    it "assigns @ratings" do
      rating = FactoryGirl.create(:rating, book_id: book.id)
      get :show, id: book.id
      expect(assigns(:ratings)).to eq [rating]
    end

    it "renders index page" do
      get :show, id: book.id
      expect(response).to render_template "show"
    end
  end 
end
