class ShippingAddressesController < ApplicationController
  def new
    if current_order.shipping_address.persisted?
      redirect_to new_credit_card_url
    else
  	  @shipping_address = current_order.build_shipping_address
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @billing_address.update_attributes(address_params)
      redirect_to order_url(current_order.id)
    else 
      redirect_to :back, notice: @shipping_address.errors.first
    end
  end
private
  def address_params 
    params.require(:shipping_address).permit(:city, :phone, :adress, :first_name, :last_name, :zipcode, :country)
  end
end
