class OrderitemsController < ApplicationController
  before_filter :set_items, :except => :create

  def create
  	@orderitem = current_order.orderitems.create(orderitem_params)
    redirect_to :back, notice: "Book was added to cart!" 
  end

  def update
  	@orderitem.update_attributes(orderitem_params)
  	@orderitems = current_order.orderitems
  end

  def destroy
  	@orderitem.destroy
  	@orderitems = current_order.orderitems
  end

private
  def set_items
    @orderitem = current_order.orderitems.find(params[:id])
  end

  def orderitem_params
  	params.require(:orderitem).permit(:quantity, :book_id)
  end
end
