require 'spec_helper'

RSpec.describe BillingAddressesController, :type => :controller do
  let(:address_params) { FactoryGirl.attributes_for(:billing_address).stringify_keys }
  describe "GET new" do
    context "with billing address present" do
      it "redirects to shipping_address_path" do
        Order.any_instance.stub_chain(:billing_address, :present?).and_return true
        get :new
        expect(response).to redirect_to new_shipping_address_path(locale: 'en')
      end
    end

    context "without billing address present" do
      before do
        Order.any_instance.stub_chain(:billing_address, :present?).and_return false
      end
      it "assings @billing_address" do
        get :new
        expect(assigns(:billing_address)).to be_a_new(BillingAddress)
      end

      it "renders template new if billing_address apsent" do
        get :new
        expect(response).to render_template("new")
      end
    end
  end
  describe "PUT create" do
    it "assigns @billing_address" do
      put :create, billing_address: address_params
      expect(assigns(:billing_address)).not_to be_nil
    end      
    it "assings @billing_address with new record" do
      billing_address = FactoryGirl.create(:billing_address)
      put :create, billing_address: address_params
      expect(assigns(:billing_address)).not_to eq billing_address
    end

    context "with passed save" do
      before do
        BillingAddress.any_instance.stub(:save).and_return true
      end

      it "redirects to shipping address page" do
        put :create, billing_address: address_params
        expect(response).to redirect_to new_shipping_address_path(locale: 'en')
      end 
    end

    context "with failed save" do
      before do
        BillingAddress.any_instance.stub(:save).and_return false
      end

      it "redirects to back with notice" do
        request.env['HTTP_REFERER'] = new_billing_address_path(locale: 'en', notice: "aaa")
        put :create, billing_address: address_params 
        expect(response).to redirect_to new_billing_address_path(locale: 'en', notice: "aaa")
      end
    end
  end

  describe "GET edit" do
    let(:billing_address) { FactoryGirl.build_stubbed(:billing_address) }

    it "renders edit template" do
      get :edit, id: billing_address.id
      expect(response).to render_template "edit"
    end
  end

  describe "PUT update" do
    let(:billing_address) { FactoryGirl.create(:billing_address) }

    before do
      BillingAddress.stub(:find).and_return billing_address
    end

    it "assigns @billing_address" do
      put :update, id: billing_address.id, billing_address: address_params
      expect(assigns(:billing_address)).to eq billing_address
    end

    context "with passed update" do
      let(:current_order) { FactoryGirl.create(:order) }

      before do
        billing_address.stub(:update_attributes).and_return true
        controller.stub(:current_order).and_return current_order
      end

      it "redirects to order path after update" do
        put :update, id: billing_address.id, billing_address: address_params
        expect(response).to redirect_to order_path(id: current_order.id, locale: 'en')
      end
    end

    context "with failed update" do
      before do
        BillingAddress.any_instance.stub(:update_attributes).and_return false
      end

      it "redirects to back with notice" do
        request.env['HTTP_REFERER'] = edit_billing_address_path(id: billing_address.id, locale: 'en', notice: "aaa")
        put :update, id: billing_address.id, billing_address: address_params 
        expect(response).to redirect_to edit_billing_address_path(id: billing_address.id, locale: 'en', notice: "aaa")
      end
    end
  end

end
