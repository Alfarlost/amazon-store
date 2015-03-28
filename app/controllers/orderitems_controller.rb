class OrderitemsController < ApplicationController
  before_filter :set_items, :only => :destroy

  def create
  	@orderitem = current_order.orderitems.build(orderitem_params)
    if @orderitem.save
      redirect_to cart_path, notice: I18n.t('orderitems.book.added')
    else
      redirect_to :back, notice: @orderitem.errors.first
    end
  end

  def update
    if current_order.orderitems.update(orderitems_params[:orderitems].keys, orderitems_params[:orderitems].values)
      redirect_to cart_path, notice: I18n.t('orderitems.book.updated')
    else
      redirect_to :back, notice: @orderitems.errors.first
    end
  end

  def destroy
  	if @orderitem.destroy
  	  redirect_to :back, notice: I18n.t('orderitems.book.removed')
    else
      redirect_to :back, notice: @orderitem.errors.first
    end
  end

private
  def set_items
    @orderitem = current_order.orderitems.find(params[:id])
  end

  def orderitem_params
    params.require(:orderitem).permit(:quantity, :book_id)
  end

  def orderitems_params
    params.require(:order).permit(:orderitems => [:id, :quantity, :book_id])
  end
end
