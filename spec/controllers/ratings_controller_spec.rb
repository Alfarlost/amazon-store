require 'rails_helper'

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
      expect(response).to render_template "new"
    end 
  end

  describe "PUT #create" do
    let(:rating_params) { FactoryGirl.attributes_for(:rating).stringify_keys }

    context "with passed save" do
      before do
        Rating.any_instance.stub(:save).and_return true
        put :create, rating: rating_params
      end

      it "redirects to book row" do
        expect(response).to redirect_to book_path(id: book.id, locale: 'en')
      end

      it "raises notise" do
        expect(flash[:notice]).to eq "Thank you for your review!"
      end
    end
    context "with passed save" do
      before do
        Rating.any_instance.stub(:save).and_return false
        put :create, rating: rating_params
      end
      
      it "refreshes page" do
        expect(response).to render_template :new
      end

      it "raises notise" do
        expect(flash[:notice]).to eq "Please try again."
      end
    end
  end
end
