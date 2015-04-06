class OrdersController < ApplicationController
  load_and_authorize_resource :through => :current_customer, only: :index
  load_and_authorize_resource only: [:edit, :show, :cancel]
  
  def index
    @order_in_progress = @orders.in_progress.first
    @orders_in_queue = @orders.in_queue
    @orders_complited = @orders.completed
    @orders_shipped = @orders.shipped
  end

  def show
    render 'checkout/complete'
  end

  def edit
    @orderitems = @order.orderitems
  end

  def cancel
    @order.cancel
    if @order.save
      redirect_to orders_path, notice: "Your Order ##{@order.id} was canceled."
    else
      redirect_to :back, alert: "You can't cancel this order."
    end
  end

  def apply_discount
    if params[:order][:coupone_code] != current_order.coupone_code
      if Discount.where(coupone_code: params[:order][:coupone_code]).present?
        current_order.update_attributes(coupone_params)
        current_order.update_total_price
        flash[:notice] = I18n.t('order.coupone_code.right')
      else
        flash[:alert] = I18n.t('order.coupone_code.unavailable')
      end
    else
      flash[:alert] = I18n.t('order.coupone_code.used')
    end
    redirect_to cart_path
  end

private
  def coupone_params
    params.require(:order).permit(:coupone_code)
  end
end
