class OrderitemsController < ApplicationController
  load_and_authorize_resource :only => :destroy
  load_and_authorize_resource :through => :current_order, :only => [:create, :index]
  load_and_authorize_resource :index => :update_orderitems, :through => :current_order
  
  def index
    render 'cart/show'
  end

  def create
    if @orderitem.save
      redirect_to cart_path, notice: I18n.t('orderitems.book.added')
    else
      redirect_to :back, alert: @orderitem.errors.first
    end
  end

  def destroy
    if @orderitem.destroy
      flash[:notice] = I18n.t('orderitems.book.removed')
    else
      flash[:alert] = @orderitem.errors.first
    end
    redirect_to cart_path
  end

  def update_orderitems
    if @orderitems.update(orderitems_params[:orderitems].keys, orderitems_params[:orderitems].values)
      flash.now[:notice] = I18n.t('orderitems.book.updated')
    else
      flash.now[:alert] = @orderitems.errors.first
    end
    render 'cart/show'
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
