class CartsController < ApplicationController
  def show
    @orderitems = current_order.orderitems
  end
  
  def update
    if current_order.coupone_code.nil?
      current_order.update(coupone_params)
      if current_order.coupone_code == current_order.discount.coupone_code
        current_order.calculate_discount
        redirect_to :back, notice: I18n.t('order.coupone_code.right')
      else
        redirect_to :back, alert: "Wrong Code."
      end
    else
      redirect_to :back, alert: I18n.t('order.coupone_code.unavailable')
    end
  end

  private
  def coupone_params
    params.require(:order).permit(:coupone_code)
  end
end
