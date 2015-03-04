require 'spec_helper'

describe ApplicationController, :type => :controller do
  describe "#current_order" do
    context "with order in session" do
      let(:order) { Order.create }
      it "returns order" do
        subject.session[:order_id] = order.id 
        expect(subject.current_order).to eq order
      end      
    end

    context "with order in session and with state in progress" do
      let(:order) { Order.create(state: "in queue") }
      it "returns new order" do
        subject.session[:order_id] = order.id 
        expect(subject.current_order).not_to eq order
      end
    end

    context "without order in session" do
      let(:order) { Order.create }
      it "returns new order" do
        subject.session[:order_id] = nil 
        expect(subject.current_order).not_to eq order
      end
    end
  end
end 