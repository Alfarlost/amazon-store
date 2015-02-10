class AddressesController < ApplicationController
  def create_billing_address
  	@billing_address = current_order.billing_address.build(address_params)
  	@billing_address.save
  	redirect_to :back
  end

  def create_shipping_address
  	@shipping_address = current_order.shipping_address.build(address_params)
  	@shipping_address.save
  	redirect_to :back
  end

  def update
  end

private
  def address_params
  	params.require(:address).permit(:first_name, :last_name, :addres, :city, :country, :zipcode, :phone)
  end
end
