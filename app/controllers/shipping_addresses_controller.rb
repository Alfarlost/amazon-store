class ShippingAddressesController < ApplicationController
  def new
  	@shipping_address = current_order.build_shipping_address
  end

  def create
  	@shipping_address = current_order.build_shipping_address
  	@shipping_address.save
  	if @shipping_address.save
      redirect_to new_credit_card_url
    else 
      redirect_to :back, notice: @shipping_address.errors.first
    end
  end

  def update
  end
end
