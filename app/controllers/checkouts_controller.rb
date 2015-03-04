class CheckoutsController < ApplicationController
  def new
    @checkout = Checkout.new(current_order)
  end

  def create
    @checkout = Checkout.new(current_order)
    if @checkout.submit(checkout_params)
      current_order.in_queue
      redirect_to root_path, notice: "Your order is in queue now"
    else
      redirect_to :new, notice: "Some errors in your input"
    end
  end

private
  def checkout_params
    params.require(:checkout).permit(:number, :cvv, :expiration_month, :expiration_year,
                                     :b_adress, :b_country, :b_city, :b_phone, :b_zipcode, :b_first_name, :b_last_name,
                                     :s_adress, :s_country, :s_city, :s_phone, :s_zipcode, :s_first_name, :s_last_name)
  end
end