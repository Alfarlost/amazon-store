class CustomersController < ApplicationController
  before_filter :set_data
  def edit
  end

  def update
    
  end
private
  def set_data
    @customer =  current_customer
    @shipping_address = @customer.shipping_address
    @billing_address = @customer.billing_address
    @credit_card = @customer.credit_card
  end
end
