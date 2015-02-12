class ShippingAddressesController < ApplicationController
  def new
    if current_order.shipping_address.persisted?
      redirect_to new_credit_card_url
    else
  	  @shipping_address = current_order.build_shipping_address
    end

  end

  def create
    @shipping_address = current_order.build_shipping_address(address_params)
  	if @shipping_address.save
      redirect_to new_credit_card_url
    else 
      redirect_to :back, notice: @shipping_address.errors.first
    end
  end

  def update
  end
private
  def address_params 
    params.require(:shipping_address).permit(:city, :phone, :adress, :first_name, :last_name, :zipcode, :country)
  end
end
