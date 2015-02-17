class CustomersController < Devise::RegistrationsController
  def edit
    if resource.shipping_address.present?
      resource.shipping_address.update(params[:customer][:shipping_address])
    else
      resource.create_shipping_address(params[:customer][:shipping_address])
    end
    if resource.billing_address.present?
      resource.billing_address.update(params[:customer][:billing_address])
    else
      resource.create_billing_address(params[:customer][:billing_address])
    end
    if resource.credit_card.present?
      resource.credit_card.update(params[:customer][:credit_card])
    else
      resource.create_credit_card(params[:customer][:credit_card])
    end
    super
  end
end
