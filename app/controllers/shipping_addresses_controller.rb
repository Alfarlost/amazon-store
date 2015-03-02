class ShippingAddressesController < ApplicationController
  def new
    current_order.set_shipping_address if current_order.billing_address.same == true
    if current_order.shipping_address.present?
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
      redirect_to :back, notice: @shipping_address.errors.first(8)
    end
  end

  def edit
    @shipping_address = current_order.shipping_address
  end

  def update
    @shipping_address = current_order.shipping_address
    if @shipping_address.update(address_params)
      redirect_to order_url(current_order.id)
    else 
      redirect_to :back, notice: @shipping_address.errors.first(8)
    end
  end
private
  def address_params 
    params.require(:shipping_address).permit(:city, :phone, :adress, :first_name, :last_name, :zipcode, :country)
  end
end
