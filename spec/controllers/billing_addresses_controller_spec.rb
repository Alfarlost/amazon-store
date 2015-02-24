require 'rails_helper'

RSpec.describe BillingAddressesController, :type => :controller do

  describe "GET new" do

  end

  describe "GET create" do
    context "with invalid attributes" do
      let(:billing_address) { FactoryGirl.build(:billing_address) }
      let(:address_params) { FactoryGirl.attributes_for(:billing_address).stringify_keys }
      before do
        billing_address.stub(:save).and_return true
      end
    it "returns flash message" do
      put :create, billing_address: address_params
      expect(flash[:notice]).to eq("#{billing_address.errors.first}")
    end
    it "redirects to back" do
      expect(response).to redirect_to(new_shipping_address_path)
    end 
  end
  end

  describe "GET update" do

  end

end
