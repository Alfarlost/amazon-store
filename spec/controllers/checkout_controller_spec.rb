require 'spec_helper'
RSpec.describe CheckoutController, :type => :controller do
  describe "GET #show" do
    it "assigns @checkout with new checkout object" do
      get :show, id: "adresses"
      expect(assigns(:checkout)).not_to be_nil
    end

    it "render adresses partial if on first step" do
      get :show, id: "adresses"
      expect(response).to render_template "adresses"
    end

    it "render payment partial if on second step" do
      get :show, id: "payment"
      expect(response).to render_template "payment"
    end

    it "render confirm partial if on last step" do
      get :show, id: "confirm"
      expect(response).to render_template "confirm"
    end
  end

  describe "PUT #update" do
    let(:order) { Order.create }
    let(:checkout) { Checkout.new(order) }

    before do
      params[:checkout] = {}
      Checkout.any_instance.stub(:update).and_return true
    end

    it "assigns @checkout with new checkout object" do
      put :update, id: "adresses"
      expect(assigns(:checkout)).to eq checkout
    end

    it "render adresses partial if on first step" do
      put :update, id: "adresses"
      expect(response).to render_template "payment"
    end

    it "render payment partial if on second step" do
      put :update, id: "payment"
      expect(response).to render_template "confirm"
    end

    it "render confirm partial if on last step" do
      put :update, id: "confirm"
      expect(response).to redirect_to root_path
    end
  end
end
