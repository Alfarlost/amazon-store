class BillingAddressesController < ApplicationController
  def new
    if current_order.billing_address.present?
      redirect_to new_shipping_address_url
    else
      @billing_address = current_order.build_billing_address
    end
  end

  def create
    @billing_address = current_order.build_billing_address(address_params)
    if @billing_address.save
      redirect_to new_shipping_address_url
    else 
      redirect_to :back, notice: "Sorry! We got #{@billing_address.errors.count} errors here!" 
    end
  end

  def edit
    @billing_address = current_order.billing_address
  end

  def update
    @billing_address = BillingAddress.find(params[:id])
    if @billing_address.update_attributes(address_params)
      redirect_to order_url(current_order.id)
    else 
      redirect_to :back, notice: "Sorry! We got #{@billing_address.errors.count} errors here!" 
    end
  end
  
private
  def address_params 
    params.require(:billing_address).permit(:city, :phone, :adress, :first_name, :last_name, :zipcode, :country, :same)
  end
end
