class OrdersController < ApplicationController
  def index
    @orders = current_customer.orders
  end

  def show
    @billing_address = current_order.billing_address
    @shipping_address = current_order.shipping_address
    @credit_card = current_order.credit_card
  end

  def update
    current_order.in_queue
    if current_order.save
      redirect_to root_url, notice: "Your order is in queue now."
    else 
      redirect_to :back, notice: "Something went wrong"
    end
  end
end
