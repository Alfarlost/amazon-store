class BillingAddressesController < ApplicationController
  def new
    @billing_address = current_order.build_billing_address
  end

  def create
    if @billing_address.save
      redirect_to new_shipping_address_url
    else 
      redirect_to :back, notice: @billing_address.errors.first
    end
  end

  def update
  end
end
