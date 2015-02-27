require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do

  describe "GET index" do
    it "assigns @orders" do
      current_customer = FactoryGirl.create(:customer)
      order1 = FactoryGirl.create(:order, customer_id: current_customer.id)
      order2 = FactoryGirl.create(:order, customer_id: current_customer.id)
      controller.stub(:current_customer).and_return current_customer
      get :index
      expect(assigns(:orders)).to eq [order1, order2]
    end
  end
  context "with current order" do
    let(:current_order) { FactoryGirl.create(:order) }

    before do
      controller.stub(:current_order).and_return current_order
    end

    describe "GET show" do
      it "assigns @billing_address" do
        billing_address = FactoryGirl.create(:billing_address, order_id: current_order.id)
        get :show, id: current_order.id
        expect(assigns(:billing_address)).to eq billing_address
      end

      it "assigns @shipping_address" do
        shipping_address = FactoryGirl.create(:shipping_address, order_id: current_order.id)
        get :show, id: current_order.id
        expect(assigns(:shipping_address)).to eq shipping_address
      end   

      it "assigns @credit_card" do
        credit_card = FactoryGirl.create(:credit_card, order_id: current_order.id)
        get :show, id: current_order.id
        expect(assigns(:credit_card)).to eq credit_card
      end

      it "renders show page" do
        get :show, id: current_order.id
        expect(response).to render_template "show"
      end
    end

    describe "PUT update" do
      let(:order_params) { FactoryGirl.attributes_for(:order).stringify_keys }
      before do
        put :update, id: current_order.id, order: order_params
      end

      it "redirect to back" do
        expect(response).to redirect_to root_path(locale: 'en')
      end
      it "sends notice" do
        expect(flash[:notice]).to eq "Your order is in queue now."
      end
      
    end
  end
end
