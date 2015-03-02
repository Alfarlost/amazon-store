require 'rails_helper'

RSpec.describe ShippingAddressesController, :type => :controller do
let(:address_params) { FactoryGirl.attributes_for(:shipping_address).stringify_keys }
  describe "GET new" do
    context "with shipping_address present" do
      it "redirects to shipping_address_path" do
        Order.any_instance.stub_chain(:shipping_address, :present?).and_return true
        get :new
        expect(response).to redirect_to new_credit_card_path(locale: 'en')
      end
    end

    context "without shipping_address present" do
      before do
        Order.any_instance.stub_chain(:shipping_address, :present?).and_return false
      end
      it "assings @shipping_address" do
        get :new
        expect(assigns(:shipping_address)).to be_a_new(ShippingAddress)
      end

      it "renders template new" do
        get :new
        expect(response).to render_template "new"
      end
    end
  end
  describe "PUT create" do
    it "assigns @shipping_address" do
      put :create, shipping_address: address_params
      expect(assigns(:shipping_address)).not_to be_nil
    end      
    it "assings @shipping_address with new record" do
      shipping_address = FactoryGirl.create(:shipping_address)
      put :create, shipping_address: address_params
      expect(assigns(:shipping_address)).not_to eq shipping_address
    end

    context "with passed save" do
      before do
        ShippingAddress.any_instance.stub(:save).and_return true
      end

      it "redirects to shipping address page" do
        put :create, shipping_address: address_params
        expect(response).to redirect_to new_credit_card_path(locale: 'en')
      end 
    end

    context "with failed save" do
      before do
        ShippingAddress.any_instance.stub(:save).and_return false
        request.env['HTTP_REFERER'] = new_shipping_address_path(locale: 'en')
        put :create, shipping_address: address_params 
      end

      it "redirects to back" do
        expect(response).to redirect_to new_shipping_address_path(locale: 'en')
      end

      it "raises flash notice" do
        shipping_address = FactoryGirl.build_stubbed(:shipping_address)
        expect(flash[:notice]).to eq shipping_address.errors.first(8)
      end
    end
  end

  describe "GET edit" do
    let(:shipping_address) { FactoryGirl.build_stubbed(:shipping_address) }

    it "renders edit template" do
      get :edit, id: shipping_address.id
      expect(response).to render_template "edit"
    end
  end

  describe "PUT update" do
    let(:current_order) { FactoryGirl.create(:order) }
    let(:shipping_address) { FactoryGirl.create(:shipping_address, order_id: current_order.id) }

    before do
      controller.stub(:current_order).and_return current_order
    end

    it "assigns @shipping_address" do
      put :update, id: shipping_address.id, shipping_address: address_params
      expect(assigns(:shipping_address)).to eq shipping_address
    end

    context "with passed update" do

      before do
        current_order.stub(:shipping_address).and_return shipping_address
        shipping_address.stub(:update).and_return true
      end

      it "redirects to order path after update" do
        put :update, id: shipping_address.id, shipping_address: address_params
        expect(response).to redirect_to order_path(id: current_order.id, locale: 'en')
      end
    end

    context "with failed update" do
      before do
        current_order.stub(:shipping_address).and_return shipping_address
        shipping_address.stub(:update).and_return false
        request.env['HTTP_REFERER'] = edit_shipping_address_path(id: shipping_address.id, locale: 'en')
        put :update, id: shipping_address.id, shipping_address: address_params 
      end

      it "redirects to back" do
        expect(response).to redirect_to edit_shipping_address_path(id: shipping_address.id, locale: 'en')
      end

      it "raises flash notice" do
        shipping_address = FactoryGirl.build_stubbed(:shipping_address)
        expect(flash[:notice]).to eq shipping_address.errors.first(8)
      end
    end
  end
end
