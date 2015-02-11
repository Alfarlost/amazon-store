class AddressesController < ApplicationController
  def new
  	@billing_address = current_order.build_billing_address(nil)
  	@shipping_address = current_order.build_shipping_address(nil)
  end

  def create
    @billing_address = current_order.build_billing_address
    @shipping_address = current_order.build_shipping_address
  	if @billing_address.save
      redirect_to :back
  	elsif @shipping_address.save
      redirect_to new_credit_card_url
    else 
      redirect_to :back, notice: @billing_address.errors.first
  	end
  end

  def update
  end

private
  def billing_address_params
  	params.require(:billing_address).permit(:first_name, :last_name, :adress, :city, :country, :zipcode, :phone)
  end

  def shipping_address_params
  	params.require(:shipping_address).permit(:first_name, :last_name, :adress, :city, :country, :zipcode, :phone)
  end
end
