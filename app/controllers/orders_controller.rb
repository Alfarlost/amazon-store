class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
  	@billing_address = current_order.billing_address
  	@shipping_address = current_order.shipping_address
    @credit_card = current_order.credit_card
  end

  def update
    current_order.state = "in queue"
    if current_order.save
      redirect_to :back
    else 
      redirect_to :back, notice: "Something went wrong"
    end
  end
end
