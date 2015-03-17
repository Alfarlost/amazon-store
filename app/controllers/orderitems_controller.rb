class OrderitemsController < ApplicationController
  before_filter :set_items, :except => :create

  def create
  	@orderitem = current_order.orderitems.build(orderitem_params)
    if @orderitem.save
      redirect_to :back, notice: I18n.t('orderitems.book.added')
    else
      redirect_to :back, notice: @orderitem.errors.first
    end
  end

  def update
  	if @orderitem.update(orderitem_params)
  	  redirect_to :back, notice: I18n.t('orderitems.book.updated')
    else
      redirect_to :back, notice: @orderitem.errors.first
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
  	params.require(:orderitem).permit(:quantity)
  end
end
