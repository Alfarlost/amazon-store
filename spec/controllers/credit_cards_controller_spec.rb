require 'rails_helper'

RSpec.describe CreditCardsController, :type => :controller do
  let(:credit_card_params) { FactoryGirl.attributes_for(:credit_card).stringify_keys }
  let(:current_order) { FactoryGirl.create(:order) }
  before do
    controller.stub(:current_order).and_return current_order
  end
  describe "GET new" do
    context "with credit_card present" do
      it "redirects to order_path" do
        current_order.stub_chain(:credit_card, :present?).and_return true
        get :new
        expect(response).to redirect_to order_path(id: current_order.id, locale: 'en')
      end
    end

    context "without credit_card present" do
      before do
        current_order.stub_chain(:credit_card, :present?).and_return false
      end
      it "assings @credit_card" do
        get :new
        expect(assigns(:credit_card)).to be_a_new(CreditCard)
      end

      it "renders template new" do
        get :new
        expect(response).to render_template "new"
      end
    end
  end
  describe "PUT create" do
    let(:credit_card) { FactoryGirl.create(:credit_card) }
    let(:billing_address) { FactoryGirl.create(:billing_address, order_id: current_order.id) }
    before do
      current_order.stub_chain(:billing_address, :first_name).and_return credit_card.firstname
      current_order.stub_chain(:billing_address, :last_name).and_return credit_card.lastname
    end  
    it "assigns @credit_card" do
      put :create, credit_card: credit_card_params
      expect(assigns(:credit_card)).not_to be_nil
    end

    it "assings @credit_card with new record" do
      credit_card = FactoryGirl.create(:credit_card)
      put :create, credit_card: credit_card_params
      expect(assigns(:credit_card)).not_to eq credit_card
    end

    context "with passed save" do
      before do
        CreditCard.any_instance.stub(:save).and_return true
      end

      it "redirects to shipping address page" do
        put :create, credit_card: credit_card_params
        expect(response).to redirect_to order_path(id: current_order.id, locale: 'en')
      end 
    end

    context "with failed save" do
      before do
        CreditCard.any_instance.stub(:save).and_return false
        request.env['HTTP_REFERER'] = new_credit_card_path(locale: 'en')
        put :create, credit_card: credit_card_params 
      end

      it "redirects to back" do
        expect(response).to redirect_to new_credit_card_path(locale: 'en')
      end

      it "raises flash notice" do
        credit_card = FactoryGirl.build_stubbed(:credit_card)
        expect(flash[:notice]).to eq "Something is wrong. Check your credit card information."
      end
    end
  end

  describe "GET edit" do
    let(:credit_card) { FactoryGirl.build_stubbed(:credit_card) }

    it "renders edit template" do
      get :edit, id: credit_card.id
      expect(response).to render_template "edit"
    end
  end

  describe "PUT update" do
    let(:credit_card) { FactoryGirl.create(:credit_card) }

    before do
      CreditCard.stub(:find).and_return credit_card
    end

    it "assigns @credit_card" do
      put :update, id: credit_card.id, credit_card: credit_card_params
      expect(assigns(:credit_card)).to eq credit_card
    end

    context "with passed update" do
      before do
        credit_card.stub(:update_attributes).and_return true
      end

      it "redirects to order path after update" do
        put :update, id: credit_card.id, credit_card: credit_card_params
        expect(response).to redirect_to order_path(id: current_order.id, locale: 'en')
      end
    end

    context "with failed update" do
      before do
        CreditCard.any_instance.stub(:update_attributes).and_return false
        request.env['HTTP_REFERER'] = edit_credit_card_path(id: credit_card.id, locale: 'en')
        put :update, id: credit_card.id, credit_card: credit_card_params 
      end

      it "redirects to back" do
        expect(response).to redirect_to edit_credit_card_path(id: credit_card.id, locale: 'en')
      end

      it "raises flash notice" do
        credit_card = FactoryGirl.build_stubbed(:credit_card)
        expect(flash[:notice]).to eq "Please, check your credit card information."
      end
    end
  end

end
