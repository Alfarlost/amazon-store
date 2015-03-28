class CartsController < ApplicationController
  def show
    @orderitems = current_order.orderitems.order(id: :desc)
  end
  
  def update
    if current_order.coupone_code.nil?
      if params[:order][:coupone_code] == current_order.discount.coupone_code
        current_order.update_attributes(coupone_params)
        current_order.calculate_discount
        redirect_to :back, notice: I18n.t('order.coupone_code.right')
      else
        redirect_to :back, alert: I18n.t('order.coupone_code.unavailable')
      end
    else
      redirect_to :back, alert: I18n.t('order.coupone_code.used')
    end
  end

  private
  def coupone_params
    params.require(:order).permit(:coupone_code)
  end
end
