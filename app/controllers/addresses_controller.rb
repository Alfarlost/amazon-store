class AddressesController < ApplicationController
  def create_billing_address
  	@billing_address = current_order.billing_address.build(billing_address_params)
  	@billing_address.save
  	redirect_to :back
  end

  def create_shipping_address
  	@shipping_address = current_order.shipping_address.build(shipping_address_params)
  	@shipping_address.save
  	redirect_to :back
  end

  def update
  end

private
  def billing_address_params
  	params.require(:billing_address).permit(:first_name, :last_name, :addres, :city, :country, :zipcode, :phone)
  end

  def shipping_address_params
  	params.require(:shipping_address).permit(:first_name, :last_name, :addres, :city, :country, :zipcode, :phone)
  end
end
