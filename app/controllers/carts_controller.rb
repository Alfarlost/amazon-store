class CartsController < ApplicationController
  def show
    @orderitems = current_order.orderitems
  end
  
  def update
    if current_order.coupone_code.nil?
      current_order.update(coupone_params)
      if current_order.coupone_code == current_order.discount.coupone_code
        current_order.calculate_discount
        redirect_to :back, notice: "You got 5% discount"
      else
        redirect_to :back, alert: "Wrong Code."
      end
    else
      redirect_to :back, alert: "Sorry. You already use this discount."
    end
  end

  private
  def coupone_params
    params.require(:order).permit(:coupone_code)
  end
end
