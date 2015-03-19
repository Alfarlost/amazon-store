class OrdersController < ApplicationController
  before_filter :set_order, only: [:edit,  :destroy]
  def index
    @orders = current_customer.orders
  end

  def edit
    @orderitems = @order.orderitems
  end

  def destroy
    @order.state = "canceled"
    if @order.save
      flash[:notice] = "Your Order ##{@order.id} was canceled."
      redirect_to orders_path 
    else
      redirect_to :back, notice: "Something happened."
    end
  end  

  def show
    @billing_address = current_order.billing_address
    @shipping_address = current_order.shipping_address
    @credit_card = current_order.credit_card
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end
end
