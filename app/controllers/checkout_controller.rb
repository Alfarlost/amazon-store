class CheckoutController < ApplicationController
  include Wicked::Wizard
  steps :adresses, :payment, :confirm

  def show
    @checkout = Checkout.new(current_order)
    render_wizard
  end

  def update
    @checkout = Checkout.new(current_order)
    @checkout.submit(checkout_params)
    render_wizard(@checkout)
  end

private
  def checkout_params
    permitted_attributes = case step
      when :adresses
        [:b_adress, :b_country, :b_city, :b_phone, :b_zipcode, :b_first_name, :b_last_name,
         :s_adress, :s_country, :s_city, :s_phone, :s_zipcode, :s_first_name, :s_last_name, :same_shipping_address]
      when :payment
        [:number, :cvv, :expiration_month, :expiration_year]
      end

    params.require(:checkout).permit(permitted_attributes).merge(form_step: step)
  end

  def redirect_to_finish_wizard(options = nil)
    current_order.in_queue
    redirect_to root_path, notice: "Your order is in queue now!"
  end 
end