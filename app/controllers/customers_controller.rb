class CustomersController < Devise::RegistrationsController
  def edit
    super
  end

  def update
    super 
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
    if resource.credit_card.present?
      resource.credit_card.update(credit_card_params)
    else
      resource.create_credit_card(credit_card_params)
    end   
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
end
