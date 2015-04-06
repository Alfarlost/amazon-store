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
    let(:order) { FactoryGirl.create(:order) }

    before do
      controller.stub(:current_order).and_return order
      Order.any_instance.stub(:finishable?).and_return false
      Checkout.any_instance.stub(:update).and_return true
      Checkout.any_instance.stub(:save).and_return true
      controller.class.skip_before_filter :check_step_access
    end

    it "assigns @checkout with new checkout object" do
      put :update, id: "adresses", checkout: {}
      expect(assigns(:checkout)).to be_instance_of(Checkout)
    end

    it "render delivery partial if on first step" do
      put :update, id: "adresses", checkout: {}
      expect(response).to redirect_to checkout_path("delivery", locale: 'en')
    end

    it "render payment partial if on second step" do
      put :update, id: "delivery", checkout: {}
      expect(response).to redirect_to checkout_path("payment", locale: 'en')
    end

    it "render confirm partial if on third step" do
      put :update, id: "payment", checkout: {}
      expect(response).to redirect_to checkout_path('confirm', locale: 'en')
    end

    it "render confirm partial if on last step" do
      put :update, id: "confirm", checkout: {}
      expect(response).to redirect_to '/checkout/wicked_finish?locale=en'
    end
  end
end
