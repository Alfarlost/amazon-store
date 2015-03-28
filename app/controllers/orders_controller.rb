class OrdersController < ApplicationController
  before_filter :set_order, only: [:edit, :destroy]
  def index
    @orders = current_customer.orders
    @order_in_progress = @orders.with_state("in progress").first
    @orders_in_queue = @orders.with_state("in queue")
    @orders_complited = @orders.with_state("complited")
    @orders_shipped = @orders.with_state("shipped")
  end

  def edit
    @orderitems = @order.orderitems
  end

  def destroy
    @order.cancel
    if @order.save
      redirect_to orders_path, notice: "Your Order ##{@order.id} was canceled."
    else
      redirect_to :back, notice: "You can't cancel this order."
    end
  end

private
  def set_order
    @order = Order.find(params[:id])
  end
end
