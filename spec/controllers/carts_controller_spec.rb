require 'rails_helper'

RSpec.describe CartsController, :type => :controller do

  describe "GET show" do
  	let(:order) { FactoryGirl.create(:order) }
    it "assigns @orderitems" do
      orderitem = FactoryGirl.create(:orderitem, order_id: order.id)
      controller.stub(:current_order).and_return order
      get :show, id: order.id
      expect(assigns(:orderitems)).to eq [orderitem]
    end

    it "renders index page" do
      get :show, id: order.id
      expect(response).to render_template "show"
    end
  end
end
