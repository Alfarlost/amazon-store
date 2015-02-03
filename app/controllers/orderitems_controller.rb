class OrderitemsController < ApplicationController
  before_filter :set_items, :except => :create

  def create
  	@orderitem = current_order.orderitems.build(orderitem_params)
    if @orderitem.save
      redirect_to :back, notice: "Book was added to cart!"
    else
      redirect_to :back, notice: @orderitem.errors.first
    end
  end

  def update
  	@orderitem.update(orderitem_params)
  	redirect_to :back, notice: 'Quatity was updated'
  end

  def destroy
  	@orderitem.destroy
  	redirect_to :back, notice: "Book was removed from cart!"
  end

private
  def set_items
    @orderitem = current_order.orderitems.find(params[:id])
  end

  def orderitem_params
  	params.require(:orderitem).permit(:quantity, :book_id)
  end
end
