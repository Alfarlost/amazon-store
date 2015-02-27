require 'rails_helper'

RSpec.describe OrderitemsController, :type => :controller do
  let(:orderitem_params) { FactoryGirl.attributes_for(:orderitem).stringify_keys }

  describe "PUT create" do
    let(:orderitem) { FactoryGirl.create(:orderitem) }
    before do
      request.env['HTTP_REFERER'] = root_path(locale: 'en', notice: "aaa")
    end
    it "redirects to back with some message" do
      Orderitem.any_instance.stub(:save).and_return true
      put :create, orderitem: orderitem_params
      expect(response).to redirect_to root_path(locale: 'en', notice: "aaa")
    end
  end

context "with find orderitem" do
  let(:current_order) { FactoryGirl.create(:order) }
  let(:orderitem) { FactoryGirl.create(:orderitem, order_id: current_order.id) }

  before do
    request.env['HTTP_REFERER'] = root_path(locale: 'en', notice: "aaa")
    controller.stub(:current_order).and_return current_order
    current_order.stub_chain(:orderitems, :find).and_return orderitem
  end

  describe "PUT update" do
    it "redirects to back with some message" do
      Orderitem.any_instance.stub(:update).and_return true
      put :update, id: orderitem.id, orderitem: orderitem_params
      expect(response).to redirect_to root_path(locale: 'en', notice: "aaa")
    end
  end

  describe "GET destroy" do
    it "redirects to back with some message" do
      Orderitem.any_instance.stub(:destroy).and_return true
      put :destroy, id: orderitem.id
      expect(response).to redirect_to root_path(locale: 'en', notice: "aaa")
    end
  end
end
end
