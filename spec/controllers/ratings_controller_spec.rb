require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe RatingsController, :type => :controller do
  let(:book) { FactoryGirl.create(:book) }
  let(:rating) { FactoryGirl.create(:rating, book_id: book.id) }
  login_customer

  before do
    Book.stub(:find).and_return book
  end

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template "edit"
    end 
  end

  describe "PUT #create" do
    let(:rating_params) { FactoryGirl.attributes_for(:rating).stringify_keys }

    context "with passed save" do
      before do
        Rating.any_instance.stub(:save).and_return true
      end

      it "redirects to book row" do
        put :create, rating: rating_params
        expect(response).to redirect_to book_path(book.id)
      end
    end

  end
end
