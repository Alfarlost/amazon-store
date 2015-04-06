class CustomersController < Devise::RegistrationsController
  def edit
    super
  end

  def update
    if resource.shipping_address.present?
      resource.shipping_address.update(shipping_address_params)
    else
      resource.create_shipping_address(shipping_address_params)
    end
    if resource.billing_address.present?
      resource.billing_address.update(billing_address_params)
    else
      resource.create_billing_address(billing_address_params)
    end
    current_order.set_customer(resource)
    super
  end

private
  def billing_address_params 
    params.require(:billing_address).permit(:city, :phone, :adress, :first_name, :last_name, :zipcode, :country)
  end

  def shipping_address_params 
    params.require(:shipping_address).permit(:city, :phone, :adress, :first_name, :last_name, :zipcode, :country)
  end

  def credit_card_params
    params.require(:credit_card).permit(:number, :cvv, :expiration_month, :expiration_year)
  end

  def update_resource(resource, params)
    if params[:password].blank?
      resource.update_without_password(params.except(:current_password))
    else  
      resource.update_with_password(params)
    end
  end
end
