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
      let(:order) { Order.create(state: "in_queue") }
      it "returns new order" do
        subject.session[:order_id] = order.id 
        expect(subject.current_order).not_to eq order
      end
    end

    context "without order in session" do
      let(:order) { Order.create }

      it "returns something" do
        subject.session[:order_id] = nil 
        expect(subject.current_order).not_to be_nil
      end

      it "returns order" do
        subject.session[:order_id] = nil 
        expect(subject.current_order).to be_instance_of(Order)
      end

      it "returns new order" do
        subject.session[:order_id] = nil 
        expect(subject.current_order).not_to eq(order)
      end
    end
  end
end 