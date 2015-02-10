class AddressesController < ApplicationController
  def new
  	@billing_address = current_order.addresses.build
  	@shipping_address = current_order.addresses.build
  end

  def create
  	@billing_address.save
  	@shipping_address.save
  	redirect_to :back
  end

  def update
  end

private
  def billing_address_params
  	params.require(:address).permit(:first_name, :last_name, :addres, :city, :country, :zipcode, :phone)
  end

  def shipping_address_params
  	params.require(:shipping_address).permit(:first_name, :last_name, :addres, :city, :country, :zipcode, :phone)
  end
end
