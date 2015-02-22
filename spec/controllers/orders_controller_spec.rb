require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do

  describe "GET index" do

  end

  describe "GET update" do

    it "redirect to back" do

    end

    context "with valid attributes" do
        
    end

    context "with invalid attributes" do
      let(:current_order) { FactoryGirl.create(:order) }
      before do
        current_order.stub(:save).and_return false
      end
    it "returns falsh message" do
      get :update
      expect(flash[:notice]).to eq("Something went wrong")
    end
  end
  end

end
