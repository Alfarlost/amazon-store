class OrderitemsController < ApplicationController
  before_filter :set_order
  before_filter :set_items, :except => :create

  def create
  	@orderitem = @order.orderitems.new(orderitem_params)
  	@order.save
  	session[:order_id] = @order.id
  end

  def update
  	@orderitem.update_attributes(orderitem_params)
  	@orderitems = @order.orderitems
  end

  def destroy
  	@orderitem.destroy
  	@orderitems = @order.orderitems
  end

private
  def set_order
  	@order = current_order
  end

  def set_items
    @orderitem = @order.orderitems.find(params[:id])
  end

  def orderitem_params
  	params.require(:orderitem).permit(:quantity, :book_id)
  end
end
